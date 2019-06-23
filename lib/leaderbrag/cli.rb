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
      if ENV['XMLSTATS_CONTACT_INFO'].nil?
        warn 'Please set XMLSTATS_CONTACT_INFO environment variable.'
        exit 60
      elsif ENV['XMLSTATS_API_KEY'].nil?
        warn 'Please set XMLSTATS_API_KEY environment variable'
        exit 70
      end
      @leader = Leaderbrag::Leader.new
    end

    desc 'board', 'Lists all baseball teams with their standings'
    method_option(:sort_by_league, aliases: '-l',
                                   desc: 'Sort by league.', default: false,
                                   type: :boolean)
    method_option(:only_league, aliases: '-L', type: :string,
                                desc:
                           'Only show results for this league.',
                                enum: %w[AL NL])
    method_option(:sort_by_division, aliases: '-d',
                                     desc: 'Sort by league and division.'\
                                     ' Supercedes -l.',
                                     type: :boolean)
    method_option(:only_division, aliases: '-D', type: :string,
                                  desc:
                          'Only show results for this division.',
                                  enum: %w[E C W])
    def board
      puts 'Team Name'.ljust(23) +
           'Team ID               Win%  Rank  League Rank  Div Rank'
      puts '-'.ljust(78, '-')
      teams = @leader.filter(options[:sort_by_league],
                             options[:sort_by_division],
                             options[:only_league],
                             options[:only_division])
      teams.each do |team|
        puts "#{team.first_name} #{team.last_name}:".ljust(23) +
             team.team_id.ljust(22) + team.win_percentage.ljust(7) +
             @leader.overall_rank(team).to_s.ljust(7) +
             team.conference.ljust(6) +
             @leader.league_rank(team).to_s.ljust(6) +
             team.division.ljust(4) + team.rank.to_s
      end
    end

    desc 'find', 'Finds the best team in baseball'
    method_option(:quiet, aliases: '-q',
                          desc: 'Do not print results.', default: false)
    method_option(:stats, aliases: '-s',
                          desc: 'Include team stats in output.',
                          default: false)
    method_option(:league, aliases: '-l', type: :string,
                           desc: 'Find the league leader rather than overall'\
                           ' best team.',
                           enum: %w[AL NL])
    method_option(:division, aliases: '-d', type: :string,
                             desc: 'Find the division leader rather than '\
                             'overall best team. Requires use of --league.',
                             enum: %w[E C W])
    def find
      if !options[:division].nil? && options[:league].nil?
        warn 'League must be specified.'
        exit 80
      end
      s_league = (options[:league].nil? ? nil : options[:league])
      s_division = (options[:division].nil? ? nil : options[:division])
      teams = @leader.filter(!options[:league].nil?, !options[:division].nil?,
                             s_league, s_division)
      myteam = teams[0]
      brag(myteam, options[:quiet], options[:stats])
    end

    desc 'is TEAM', 'asserts that TEAM is the best team in baseball'
    method_option(:quiet, aliases: '-q', type: :boolean,
                          desc: 'Do not print results', default: false)
    method_option(:stats, aliases: '-s', type: :boolean,
                          desc: 'Include team stats in output',
                          default: false)
    method_option(:league, aliases: '-l', type: :boolean,
                           desc: 'Check leadership of team\'s league. '\
                           'Only affects exit code.',
                           default: false)
    method_option(:division, aliases: '-d', type: :boolean,
                             desc: 'Check leadership of team\'s division.'\
                             'Only affects the exit code.',
                             default: false)
    def is?(team_id)
      myteam = @leader.team(team_id)
      if myteam.nil?
        warn "No such team with ID #{options['team']}"
        exit 50
      end
      brag(myteam, options[:quiet], options[:stats])
      if @leader.overall_leader?(myteam) ||
         (options[:league] && @leader.league_leader?(myteam)) ||
         (options[:division] && @leader.division_leader?(myteam))
        exit 0
      else
        exit myteam.rank
      end
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
    end
  end
end
