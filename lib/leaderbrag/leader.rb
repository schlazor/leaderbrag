# frozen_string_literal: true

require 'xmlstats'
require 'date'
module Leaderbrag
  # Mostly wraps MLB standings adding some additional leadership checks
  class Leader
    attr_reader :standings
    def initialize(date = Date.today)
      Xmlstats.cacher = if ENV['XMLSTATS_CACHER'] == 'redis'
                          host = '127.0.0.1'
                          if ENV.key? 'XMLSTATS_REDIS_HOST'
                            host = ENV['XMLSTATS_REDIS_HOST']
                          end
                          Xmlstats::Cachers::Redis.new(host: host)
                        else
                          Xmlstats::Cachers::Memory.new
                        end
      begin
        @standings = Xmlstats.mlb_standing(date)
      rescue Redis::CannotConnectError
        warn "WARN: Redis host #{ENV['XMLSTATS_REDIS_HOST']} "\
        'not available. Falling back to memory cacher.'
        Xmlstats.cacher = Xmlstats::Cachers::Memory.new
        @standings = Xmlstats.mlb_standing(date)
      end
      @standings.sort_by! do |team|
        team.win_percentage.to_f
      end
      @standings.reverse!
    end

    def team(team_id)
      @standings.detect do |team|
        team.team_id == team_id
      end
    end

    def division_leader?(team)
      return true if team.rank == 1

      false
    end

    def league_members(team)
      @standings.select do |t|
        team.conference == t.conference
      end
    end

    def league_leader?(team)
      return true if team.team_id == league_members(team)[0].team_id

      false
    end

    def league_rank(team)
      league_members(team).find_index(team) + 1
    end

    def overall_leader?(team)
      return true if team.team_id == @standings[0].team_id

      false
    end

    def overall_rank(team)
      @standings.find_index(team) + 1
    end

    def filter(sb_league = false, sb_division = false,
               s_conference = nil, s_division = nil)
      view = standings.sort_by do |team|
        sort_items = []
        sort_items << team.conference if sb_league
        sort_items << team.conference if sb_division
        sort_items << team.division if sb_division
        sort_items << league_rank(team) if sb_league
        sort_items << team.rank if sb_division
        sort_items << overall_rank(team) if !sb_league && !sb_division
        sort_items
      end
      unless s_conference.nil?
        view.select! do |team|
          team.conference == s_conference
        end
      end
      unless s_division.nil?
        view.select! do |team|
          team.division == s_division
        end
      end
      view
    end
  end
end
