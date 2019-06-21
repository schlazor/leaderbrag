# frozen_string_literal: true

require 'thor'
require 'xmlstats'
require 'redis'
module Leaderbrag
  # A CLI for Leaderbrag
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    @standings = nil

    def initialize(args = [], local_options = {}, config = {})
      super
      Xmlstats.cacher = Xmlstats::Cachers::Redis.new(host: '127.0.0.1')
      @standings = Xmlstats.mlb_standing
      @standings.sort_by! do |team|
        team.win_percentage.to_f
      end
      @standings.reverse!
    end

    desc 'list', 'Lists all baseball teams with their standings'
    def list
      puts 'Team Name'.ljust(23) + 'Team ID               Win% League Div'
      @standings.each do |team|
        puts "#{team.first_name} #{team.last_name}:".ljust(23) +
             team.team_id.ljust(22) + team.win_percentage.ljust(5) +
             team.conference.ljust(7) + team.division
      end
    end

    desc 'find', 'Finds the best team in baseball'
    method_option(:quiet, aliases: '-q',
                          desc: 'Do not print results', default: false)
    method_option(:stats, aliases: '-s',
                          desc: 'Include team stats in output',
                          default: false)
    def find
      myteam = @standings[0]
      brag(myteam, options[:quiet], options[:stats])
    end

    desc 'is TEAM', 'asserts that TEAM is the best team in baseball'
    method_option(:quiet, aliases: '-q',
                          desc: 'Do not print results', default: false)
    method_option(:stats, aliases: '-s',
                          desc: 'Include team stats in output',
                          default: false)
    def is?(team_id)
      myteam = team(team_id)
      if myteam.nil?
        warn "No such team with ID #{options['team']}"
        exit 50
      end
      brag(myteam, options[:quiet], options[:stats])
    end

    private

    def team(team_id)
      @standings.detect do |team|
        team.team_id == team_id
      end
    end

    def division_leader?(team)
      return true if team.rank == 1

      false
    end

    def league_leader?(team)
      leaguemates = @standings.select do |t|
        team.conference == t.conference
      end
      return true if team.team_id == leaguemates[0].team_id

      false
    end

    def overall_leader?(team)
      return true if team.team_id == @standings[0].team_id

      false
    end

    def brag(myteam, quiet, stats)
      name = "#{myteam.first_name}"\
             " #{myteam.last_name}"
      league = myteam.conference
      division = myteam.division
      unless quiet
        print "The #{name} are "
        print 'not ' unless division_leader?(myteam)
        puts "the leaders of the #{league} #{division} division."
        print "The #{name} are "
        print 'not ' unless league_leader?(myteam)
        puts "the leaders of the #{league}."
        print "The #{name} are "
        print 'not ' unless overall_leader?(myteam)
        puts 'the best team in baseball.'
      end

      if stats
        myteam.fields.each do |field|
          k = field.to_s
          next if %w[team_id first_name last_name ordinal_rank].include?(k)

          label = k.gsub(/_/, ' ').capitalize + ': '
          puts label.ljust(30) + myteam.send(field).to_s
        end
      end
      if overall_leader?(myteam)
        exit 0
      else
        exit myteam.rank
      end
    end
  end
end
