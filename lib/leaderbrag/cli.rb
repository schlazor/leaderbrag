# frozen_string_literal: true

require 'thor'
require 'leaderbrag/leader'
require 'redis'
module Leaderbrag
  # A CLI for Leaderbrag
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    @leader = nil
    def initialize(args = [], local_options = {}, config = {})
      super
      @leader = Leaderbrag::Leader.new
    end

    desc 'board', 'Lists all baseball teams with their standings'
    def board
      puts 'Team Name'.ljust(23) +
           'Team ID               Rank  Win%  League  Div'
      puts '-'.ljust(68, '-')
      @leader.standings.each_with_index do |team, i|
        puts "#{team.first_name} #{team.last_name}:".ljust(23) +
             team.team_id.ljust(22) + (i + 1).to_s.ljust(6) +
             team.win_percentage.ljust(6) +
             team.conference.ljust(8) + team.division
      end
    end

    desc 'find', 'Finds the best team in baseball'
    method_option(:quiet, aliases: '-q',
                          desc: 'Do not print results', default: false)
    method_option(:stats, aliases: '-s',
                          desc: 'Include team stats in output',
                          default: false)
    def find
      myteam = @leader.standings[0]
      brag(myteam, options[:quiet], options[:stats])
    end

    desc 'is TEAM', 'asserts that TEAM is the best team in baseball'
    method_option(:quiet, aliases: '-q',
                          desc: 'Do not print results', default: false)
    method_option(:stats, aliases: '-s',
                          desc: 'Include team stats in output',
                          default: false)
    def is?(team_id)
      myteam = @leader.team(team_id)
      if myteam.nil?
        warn "No such team with ID #{options['team']}"
        exit 50
      end
      brag(myteam, options[:quiet], options[:stats])
    end

    private

    def brag(myteam, quiet, stats)
      name = "#{myteam.first_name}"\
             " #{myteam.last_name}"
      league = myteam.conference
      division = myteam.division
      unless quiet
        print "The #{name} are "
        print 'not ' unless @leader.division_leader?(myteam)
        print "the leaders of the #{league} #{division} division."
        unless @leader.division_leader?(myteam)
          print " They are #{myteam.ordinal_rank}."
        end
        print "\nThe #{name} are "
        print 'not ' unless @leader.league_leader?(myteam)
        print "the leaders of the #{league}."
        unless @leader.league_leader?(myteam)
          print " They are ##{@leader.league_rank(myteam)}."
        end
        print "\nThe #{name} are "
        print 'not ' unless @leader.overall_leader?(myteam)
        print 'the best team in baseball.'
        unless @leader.overall_leader?(myteam)
          print " They are ##{@leader.overall_rank(myteam)}."
        end
        puts
      end

      if stats
        myteam.fields.each do |field|
          k = field.to_s
          next if %w[team_id first_name last_name ordinal_rank].include?(k)

          label = k.gsub(/_/, ' ').capitalize + ': '
          puts label.ljust(30) + myteam.send(field).to_s
        end
      end
      if @leader.overall_leader?(myteam)
        exit 0
      else
        exit myteam.rank
      end
    end
  end
end
