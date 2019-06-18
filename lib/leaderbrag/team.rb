# frozen_string_literal: true

require 'leaderbrag/standings'
module Leaderbrag
  # a baseball team
  class Team
    attr_reader :name, :team_standings, :division_leader, :league_leader
    attr_reader :overall_leader, :baseball_standings
    alias division_leader? division_leader
    alias league_leader? league_leader
    alias overall_leader? overall_leader
    def initialize(name, standings = nil)
      @name = name
      if standings.nil?
        @baseball_standings = Leaderbrag::Standings.new.standings
      end
      @baseball_standings = standings unless standings.nil?
      @team_standings = find_team
      return if @team_standings.nil?

      find_division_leader
      find_league_leader
      find_overall_leader
    end

    def find_team
      myteams = @baseball_standings['standing'].select do |team|
        team['team_id'] == name
      end
      myteams.length == 1 ? myteams[0] : nil
    end

    def find_division_leader
      @division_leader = @team_standings['games_back'] == 0.0
    end

    def find_division_leaders
      @baseball_standings['standing'].select do |team|
        team['rank'] == 1
      end
    end

    def find_overall_leader
      division_leaders = find_division_leaders
      division_leaders.sort_by! do |team|
        team['win_percentage'].to_f
      end
      dl_id = division_leaders[division_leaders.length - 1]['team_id']
      @overall_leader = false
      @overall_leader = true if dl_id == @name
    end

    def find_league_leader
      division_leaders = find_division_leaders
      league_leaders = division_leaders.select do |team|
        @team_standings['conference'] == team['conference']
      end
      league_leaders.sort_by! do |team|
        team['win_percentage'].to_f
      end
      ll_id = league_leaders[league_leaders.length - 1]['team_id']
      @league_leader = false
      @league_leader = true if ll_id == name
    end
  end
end
