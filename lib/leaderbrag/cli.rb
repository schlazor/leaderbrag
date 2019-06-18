# frozen_string_literal: true

require 'thor'
require 'leaderbrag/team'
module Leaderbrag
  # A CLI for Leaderbrag
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    @standings = nil
    desc 'list', 'Lists all baseball team IDs'
    def list
      standings = Leaderbrag::Standings.new.standings
      standings['standing'].each do |team|
        puts "#{team['first_name']} #{team['last_name']}:".ljust(23) +
             team['team_id']
      end
    end

    desc 'find', 'Finds the best team in baseball'
    method_option(:quiet, aliases: '-q',
                          desc: 'Do not print results', default: false)
    method_option(:stats, aliases: '-s',
                          desc: 'Include team stats in output',
                          default: false)
    def find
      @standings = Leaderbrag::Standings.new.standings
      @standings['standing'].sort_by! do |team|
        team['win_percentage'].to_f
      end
      i = @standings['standing'].length - 1
      myteam = Leaderbrag::Team.new(@standings['standing'][i]['team_id'],
                                    @standings)
      brag(myteam, options[:quiet], options[:stats])
    end

    desc 'is TEAM', 'asserts that TEAM is the best team in baseball'
    method_option(:quiet, aliases: '-q',
                          desc: 'Do not print results', default: false)
    method_option(:stats, aliases: '-s',
                          desc: 'Include team stats in output',
                          default: false)
    def is?(team)
      myteam = Leaderbrag::Team.new(team)
      if myteam.team_standings.nil?
        warn "No such team with ID #{options['team']}"
        exit 50
      end
      brag(myteam, options[:quiet], options[:stats])
    end

    private

    def brag(myteam, quiet, stats)
      name = "#{myteam.team_standings['first_name']}"\
             " #{myteam.team_standings['last_name']}"
      league = myteam.team_standings['conference']
      division = myteam.team_standings['division']
      unless quiet
        print "The #{name} are "
        print 'not ' unless myteam.division_leader?
        puts "the leaders of the #{league} #{division} division."
        print "The #{name} are "
        print 'not ' unless myteam.league_leader?
        puts "the leaders of the #{league}."
        print "The #{name} are "
        print 'not ' unless myteam.overall_leader?
        puts 'the best team in baseball.'
      end

      if stats
        myteam.team_standings.each do |k, v|
          next if k == 'team_id'
          next if k == 'first_name'
          next if k == 'last_name'
          next if k == 'ordinal_rank'

          label = k.gsub(/_/, ' ').capitalize + ':'
          puts "#{label.ljust(30)} #{v}"
        end
      end
      if myteam.overall_leader?
        exit 0
      else
        exit myteam.team_standings['rank']
      end
    end
  end
end
