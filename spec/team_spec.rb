# frozen_string_literal: true

require 'leaderbrag/team'

describe Leaderbrag::Team do
  before(:context) do
    # rubocop:disable Metrics/LineLength
    @standings = { 'standings_date' => '2019-06-16T19:44:00-04:00', 'standing' => [{ 'rank' => 1, 'won' => 47, 'lost' => 23, 'streak' => 'L1', 'ordinal_rank' => '1st', 'first_name' => 'Minnesota', 'last_name' => 'Twins', 'team_id' => 'minnesota-twins', 'games_back' => 0.0, 'points_for' => 417, 'points_against' => 301, 'home_won' => 23, 'home_lost' => 11, 'away_won' => 24, 'away_lost' => 12, 'conference_won' => 44, 'conference_lost' => 19, 'division_won' => 16, 'division_lost' => 7, 'last_five' => '3-2', 'last_ten' => '7-3', 'conference' => 'AL', 'division' => 'C', 'points_scored_per_game' => '6.0', 'points_allowed_per_game' => '4.3', 'win_percentage' => '.671', 'point_differential' => 116, 'point_differential_per_game' => '1.7', 'streak_type' => 'loss', 'streak_total' => 1, 'games_played' => 70 }, { 'rank' => 2, 'won' => 37, 'lost' => 33, 'streak' => 'W3', 'ordinal_rank' => '2nd', 'first_name' => 'Cleveland', 'last_name' => 'Indians', 'team_id' => 'cleveland-indians', 'games_back' => 10.0, 'points_for' => 300, 'points_against' => 291, 'home_won' => 20, 'home_lost' => 17, 'away_won' => 17, 'away_lost' => 16, 'conference_won' => 33, 'conference_lost' => 28, 'division_won' => 13, 'division_lost' => 14, 'last_five' => '4-1', 'last_ten' => '7-3', 'conference' => 'AL', 'division' => 'C', 'points_scored_per_game' => '4.3', 'points_allowed_per_game' => '4.2', 'win_percentage' => '.529', 'point_differential' => 9, 'point_differential_per_game' => '0.1', 'streak_type' => 'win', 'streak_total' => 3, 'games_played' => 70 }, { 'rank' => 3, 'won' => 34, 'lost' => 36, 'streak' => 'L2', 'ordinal_rank' => '3rd', 'first_name' => 'Chicago', 'last_name' => 'White Sox', 'team_id' => 'chicago-white-sox', 'games_back' => 13.0, 'points_for' => 302, 'points_against' => 359, 'home_won' => 20, 'home_lost' => 17, 'away_won' => 14, 'away_lost' => 19, 'conference_won' => 33, 'conference_lost' => 33, 'division_won' => 18, 'division_lost' => 14, 'last_five' => '3-2', 'last_ten' => '5-5', 'conference' => 'AL', 'division' => 'C', 'points_scored_per_game' => '4.3', 'points_allowed_per_game' => '5.1', 'win_percentage' => '.486', 'point_differential' => -57, 'point_differential_per_game' => '-0.8', 'streak_type' => 'loss', 'streak_total' => 2, 'games_played' => 70 }, { 'rank' => 4, 'won' => 25, 'lost' => 43, 'streak' => 'L4', 'ordinal_rank' => '4th', 'first_name' => 'Detroit', 'last_name' => 'Tigers', 'team_id' => 'detroit-tigers', 'games_back' => 21.0, 'points_for' => 236, 'points_against' => 368, 'home_won' => 11, 'home_lost' => 24, 'away_won' => 14, 'away_lost' => 19, 'conference_won' => 22, 'conference_lost' => 33, 'division_won' => 12, 'division_lost' => 17, 'last_five' => '1-4', 'last_ten' => '2-8', 'conference' => 'AL', 'division' => 'C', 'points_scored_per_game' => '3.5', 'points_allowed_per_game' => '5.4', 'win_percentage' => '.368', 'point_differential' => -132, 'point_differential_per_game' => '-1.9', 'streak_type' => 'loss', 'streak_total' => 4, 'games_played' => 68 }, { 'rank' => 5, 'won' => 23, 'lost' => 48, 'streak' => 'W1', 'ordinal_rank' => '5th', 'first_name' => 'Kansas City', 'last_name' => 'Royals', 'team_id' => 'kansas-city-royals', 'games_back' => 24.5, 'points_for' => 296, 'points_against' => 365, 'home_won' => 14, 'home_lost' => 23, 'away_won' => 9, 'away_lost' => 25, 'conference_won' => 21, 'conference_lost' => 45, 'division_won' => 11, 'division_lost' => 18, 'last_five' => '2-3', 'last_ten' => '4-6', 'conference' => 'AL', 'division' => 'C', 'points_scored_per_game' => '4.2', 'points_allowed_per_game' => '5.1', 'win_percentage' => '.324', 'point_differential' => -69, 'point_differential_per_game' => '-1.0', 'streak_type' => 'win', 'streak_total' => 1, 'games_played' => 71 }, { 'rank' => 1, 'won' => 43, 'lost' => 27, 'streak' => 'W2', 'ordinal_rank' => '1st', 'first_name' => 'New York', 'last_name' => 'Yankees', 'team_id' => 'new-york-yankees', 'games_back' => 0.0, 'points_for' => 379, 'points_against' => 307, 'home_won' => 22, 'home_lost' => 13, 'away_won' => 21, 'away_lost' => 14, 'conference_won' => 37, 'conference_lost' => 23, 'division_won' => 19, 'division_lost' => 7, 'last_five' => '2-3', 'last_ten' => '5-5', 'conference' => 'AL', 'division' => 'E', 'points_scored_per_game' => '5.4', 'points_allowed_per_game' => '4.4', 'win_percentage' => '.614', 'point_differential' => 72, 'point_differential_per_game' => '1.0', 'streak_type' => 'win', 'streak_total' => 2, 'games_played' => 70 }, { 'rank' => 2, 'won' => 43, 'lost' => 28, 'streak' => 'W1', 'ordinal_rank' => '2nd', 'first_name' => 'Tampa Bay', 'last_name' => 'Rays', 'team_id' => 'tampa-bay-rays', 'games_back' => 0.5, 'points_for' => 336, 'points_against' => 239, 'home_won' => 20, 'home_lost' => 18, 'away_won' => 23, 'away_lost' => 10, 'conference_won' => 34, 'conference_lost' => 24, 'division_won' => 15, 'division_lost' => 11, 'last_five' => '2-3', 'last_ten' => '5-5', 'conference' => 'AL', 'division' => 'E', 'points_scored_per_game' => '4.7', 'points_allowed_per_game' => '3.4', 'win_percentage' => '.606', 'point_differential' => 97, 'point_differential_per_game' => '1.4', 'streak_type' => 'win', 'streak_total' => 1, 'games_played' => 71 }, { 'rank' => 3, 'won' => 39, 'lost' => 34, 'streak' => 'W5', 'ordinal_rank' => '3rd', 'first_name' => 'Boston', 'last_name' => 'Red Sox', 'team_id' => 'boston-red-sox', 'games_back' => 5.5, 'points_for' => 394, 'points_against' => 345, 'home_won' => 17, 'home_lost' => 17, 'away_won' => 22, 'away_lost' => 17, 'conference_won' => 37, 'conference_lost' => 31, 'division_won' => 16, 'division_lost' => 14, 'last_five' => '5-0', 'last_ten' => '6-4', 'conference' => 'AL', 'division' => 'E', 'points_scored_per_game' => '5.4', 'points_allowed_per_game' => '4.7', 'win_percentage' => '.534', 'point_differential' => 49, 'point_differential_per_game' => '0.7', 'streak_type' => 'win', 'streak_total' => 5, 'games_played' => 73 }, { 'rank' => 4, 'won' => 26, 'lost' => 45, 'streak' => 'W1', 'ordinal_rank' => '4th', 'first_name' => 'Toronto', 'last_name' => 'Blue Jays', 'team_id' => 'toronto-blue-jays', 'games_back' => 17.5, 'points_for' => 280, 'points_against' => 359, 'home_won' => 12, 'home_lost' => 22, 'away_won' => 14, 'away_lost' => 23, 'conference_won' => 24, 'conference_lost' => 34, 'division_won' => 8, 'division_lost' => 13, 'last_five' => '3-2', 'last_ten' => '3-7', 'conference' => 'AL', 'division' => 'E', 'points_scored_per_game' => '3.9', 'points_allowed_per_game' => '5.1', 'win_percentage' => '.366', 'point_differential' => -79, 'point_differential_per_game' => '-1.1', 'streak_type' => 'win', 'streak_total' => 1, 'games_played' => 71 }, { 'rank' => 5, 'won' => 21, 'lost' => 50, 'streak' => 'L5', 'ordinal_rank' => '5th', 'first_name' => 'Baltimore', 'last_name' => 'Orioles', 'team_id' => 'baltimore-orioles', 'games_back' => 22.5, 'points_for' => 284, 'points_against' => 435, 'home_won' => 9, 'home_lost' => 28, 'away_won' => 12, 'away_lost' => 22, 'conference_won' => 19, 'conference_lost' => 46, 'division_won' => 10, 'division_lost' => 23, 'last_five' => '0-5', 'last_ten' => '2-8', 'conference' => 'AL', 'division' => 'E', 'points_scored_per_game' => '4.0', 'points_allowed_per_game' => '6.1', 'win_percentage' => '.296', 'point_differential' => -151, 'point_differential_per_game' => '-2.1', 'streak_type' => 'loss', 'streak_total' => 5, 'games_played' => 71 }, { 'rank' => 1, 'won' => 48, 'lost' => 24, 'streak' => 'L1', 'ordinal_rank' => '1st', 'first_name' => 'Houston', 'last_name' => 'Astros', 'team_id' => 'houston-astros', 'games_back' => 0.0, 'points_for' => 377, 'points_against' => 275, 'home_won' => 27, 'home_lost' => 11, 'away_won' => 21, 'away_lost' => 13, 'conference_won' => 45, 'conference_lost' => 22, 'division_won' => 21, 'division_lost' => 6, 'last_five' => '3-2', 'last_ten' => '6-4', 'conference' => 'AL', 'division' => 'W', 'points_scored_per_game' => '5.2', 'points_allowed_per_game' => '3.8', 'win_percentage' => '.667', 'point_differential' => 102, 'point_differential_per_game' => '1.4', 'streak_type' => 'loss', 'streak_total' => 1, 'games_played' => 72 }, { 'rank' => 2, 'won' => 38, 'lost' => 33, 'streak' => 'L1', 'ordinal_rank' => '2nd', 'first_name' => 'Texas', 'last_name' => 'Rangers', 'team_id' => 'texas-rangers', 'games_back' => 9.5, 'points_for' => 400, 'points_against' => 366, 'home_won' => 24, 'home_lost' => 12, 'away_won' => 14, 'away_lost' => 21, 'conference_won' => 30, 'conference_lost' => 26, 'division_won' => 19, 'division_lost' => 20, 'last_five' => '2-3', 'last_ten' => '6-4', 'conference' => 'AL', 'division' => 'W', 'points_scored_per_game' => '5.6', 'points_allowed_per_game' => '5.2', 'win_percentage' => '.535', 'point_differential' => 34, 'point_differential_per_game' => '0.5', 'streak_type' => 'loss', 'streak_total' => 1, 'games_played' => 71 }, { 'rank' => 3, 'won' => 36, 'lost' => 36, 'streak' => 'L1', 'ordinal_rank' => '3rd', 'first_name' => 'Oakland', 'last_name' => 'Athletics', 'team_id' => 'oakland-athletics', 'games_back' => 12.0, 'points_for' => 353, 'points_against' => 331, 'home_won' => 19, 'home_lost' => 17, 'away_won' => 17, 'away_lost' => 19, 'conference_won' => 33, 'conference_lost' => 33, 'division_won' => 17, 'division_lost' => 20, 'last_five' => '3-2', 'last_ten' => '5-5', 'conference' => 'AL', 'division' => 'W', 'points_scored_per_game' => '4.9', 'points_allowed_per_game' => '4.6', 'win_percentage' => '.500', 'point_differential' => 22, 'point_differential_per_game' => '0.3', 'streak_type' => 'loss', 'streak_total' => 1, 'games_played' => 72 }, { 'rank' => 4, 'won' => 35, 'lost' => 37, 'streak' => 'L1', 'ordinal_rank' => '4th', 'first_name' => 'Los Angeles', 'last_name' => 'Angels', 'team_id' => 'los-angeles-angels', 'games_back' => 13.0, 'points_for' => 363, 'points_against' => 366, 'home_won' => 19, 'home_lost' => 18, 'away_won' => 16, 'away_lost' => 19, 'conference_won' => 29, 'conference_lost' => 35, 'division_won' => 14, 'division_lost' => 21, 'last_five' => '3-2', 'last_ten' => '5-5', 'conference' => 'AL', 'division' => 'W', 'points_scored_per_game' => '5.0', 'points_allowed_per_game' => '5.1', 'win_percentage' => '.486', 'point_differential' => -3, 'point_differential_per_game' => '-0.0', 'streak_type' => 'loss', 'streak_total' => 1, 'games_played' => 72 }, { 'rank' => 5, 'won' => 31, 'lost' => 44, 'streak' => 'W1', 'ordinal_rank' => '5th', 'first_name' => 'Seattle', 'last_name' => 'Mariners', 'team_id' => 'seattle-mariners', 'games_back' => 18.5, 'points_for' => 391, 'points_against' => 459, 'home_won' => 13, 'home_lost' => 22, 'away_won' => 18, 'away_lost' => 22, 'conference_won' => 31, 'conference_lost' => 40, 'division_won' => 18, 'division_lost' => 22, 'last_five' => '3-2', 'last_ten' => '5-5', 'conference' => 'AL', 'division' => 'W', 'points_scored_per_game' => '5.2', 'points_allowed_per_game' => '6.1', 'win_percentage' => '.413', 'point_differential' => -68, 'point_differential_per_game' => '-0.9', 'streak_type' => 'win', 'streak_total' => 1, 'games_played' => 75 }, { 'rank' => 1, 'won' => 40, 'lost' => 31, 'streak' => 'W1', 'ordinal_rank' => '1st', 'first_name' => 'Milwaukee', 'last_name' => 'Brewers', 'team_id' => 'milwaukee-brewers', 'games_back' => 0.0, 'points_for' => 361, 'points_against' => 349, 'home_won' => 22, 'home_lost' => 13, 'away_won' => 18, 'away_lost' => 18, 'conference_won' => 38, 'conference_lost' => 26, 'division_won' => 18, 'division_lost' => 10, 'last_five' => '2-3', 'last_ten' => '6-4', 'conference' => 'NL', 'division' => 'C', 'points_scored_per_game' => '5.1', 'points_allowed_per_game' => '4.9', 'win_percentage' => '.563', 'point_differential' => 12, 'point_differential_per_game' => '0.2', 'streak_type' => 'win', 'streak_total' => 1, 'games_played' => 71 }, { 'rank' => 2, 'won' => 39, 'lost' => 31, 'streak' => 'W1', 'ordinal_rank' => '2nd', 'first_name' => 'Chicago', 'last_name' => 'Cubs', 'team_id' => 'chicago-cubs', 'games_back' => 0.5, 'points_for' => 361, 'points_against' => 299, 'home_won' => 24, 'home_lost' => 11, 'away_won' => 15, 'away_lost' => 20, 'conference_won' => 33, 'conference_lost' => 26, 'division_won' => 13, 'division_lost' => 11, 'last_five' => '2-3', 'last_ten' => '5-5', 'conference' => 'NL', 'division' => 'C', 'points_scored_per_game' => '5.2', 'points_allowed_per_game' => '4.3', 'win_percentage' => '.557', 'point_differential' => 62, 'point_differential_per_game' => '0.9', 'streak_type' => 'win', 'streak_total' => 1, 'games_played' => 70 }, { 'rank' => 3, 'won' => 36, 'lost' => 34, 'streak' => 'W1', 'ordinal_rank' => '3rd', 'first_name' => 'St. Louis', 'last_name' => 'Cardinals', 'team_id' => 'st-louis-cardinals', 'games_back' => 3.5, 'points_for' => 329, 'points_against' => 317, 'home_won' => 20, 'home_lost' => 13, 'away_won' => 16, 'away_lost' => 21, 'conference_won' => 34, 'conference_lost' => 31, 'division_won' => 15, 'division_lost' => 17, 'last_five' => '3-2', 'last_ten' => '5-5', 'conference' => 'NL', 'division' => 'C', 'points_scored_per_game' => '4.7', 'points_allowed_per_game' => '4.5', 'win_percentage' => '.514', 'point_differential' => 12, 'point_differential_per_game' => '0.2', 'streak_type' => 'win', 'streak_total' => 1, 'games_played' => 70 }, { 'rank' => 4, 'won' => 32, 'lost' => 39, 'streak' => 'W1', 'ordinal_rank' => '4th', 'first_name' => 'Pittsburgh', 'last_name' => 'Pirates', 'team_id' => 'pittsburgh-pirates', 'games_back' => 8.0, 'points_for' => 315, 'points_against' => 392, 'home_won' => 13, 'home_lost' => 18, 'away_won' => 19, 'away_lost' => 21, 'conference_won' => 25, 'conference_lost' => 37, 'division_won' => 12, 'division_lost' => 14, 'last_five' => '2-3', 'last_ten' => '2-8', 'conference' => 'NL', 'division' => 'C', 'points_scored_per_game' => '4.4', 'points_allowed_per_game' => '5.5', 'win_percentage' => '.451', 'point_differential' => -77, 'point_differential_per_game' => '-1.1', 'streak_type' => 'win', 'streak_total' => 1, 'games_played' => 71 }, { 'rank' => 5, 'won' => 31, 'lost' => 38, 'streak' => 'W1', 'ordinal_rank' => '5th', 'first_name' => 'Cincinnati', 'last_name' => 'Reds', 'team_id' => 'cincinnati-reds', 'games_back' => 8.0, 'points_for' => 296, 'points_against' => 258, 'home_won' => 16, 'home_lost' => 17, 'away_won' => 15, 'away_lost' => 21, 'conference_won' => 28, 'conference_lost' => 33, 'division_won' => 11, 'division_lost' => 17, 'last_five' => '2-3', 'last_ten' => '4-6', 'conference' => 'NL', 'division' => 'C', 'points_scored_per_game' => '4.3', 'points_allowed_per_game' => '3.7', 'win_percentage' => '.449', 'point_differential' => 38, 'point_differential_per_game' => '0.6', 'streak_type' => 'win', 'streak_total' => 1, 'games_played' => 69 }, { 'rank' => 1, 'won' => 42, 'lost' => 30, 'streak' => 'W1', 'ordinal_rank' => '1st', 'first_name' => 'Atlanta', 'last_name' => 'Braves', 'team_id' => 'atlanta-braves', 'games_back' => 0.0, 'points_for' => 386, 'points_against' => 347, 'home_won' => 22, 'home_lost' => 16, 'away_won' => 20, 'away_lost' => 14, 'conference_won' => 38, 'conference_lost' => 28, 'division_won' => 12, 'division_lost' => 9, 'last_five' => '4-1', 'last_ten' => '9-1', 'conference' => 'NL', 'division' => 'E', 'points_scored_per_game' => '5.4', 'points_allowed_per_game' => '4.8', 'win_percentage' => '.583', 'point_differential' => 39, 'point_differential_per_game' => '0.5', 'streak_type' => 'win', 'streak_total' => 1, 'games_played' => 72 }, { 'rank' => 2, 'won' => 39, 'lost' => 32, 'streak' => 'L1', 'ordinal_rank' => '2nd', 'first_name' => 'Philadelphia', 'last_name' => 'Phillies', 'team_id' => 'philadelphia-phillies', 'games_back' => 2.5, 'points_for' => 346, 'points_against' => 340, 'home_won' => 23, 'home_lost' => 14, 'away_won' => 16, 'away_lost' => 18, 'conference_won' => 34, 'conference_lost' => 29, 'division_won' => 16, 'division_lost' => 11, 'last_five' => '2-3', 'last_ten' => '5-5', 'conference' => 'NL', 'division' => 'E', 'points_scored_per_game' => '4.9', 'points_allowed_per_game' => '4.8', 'win_percentage' => '.549', 'point_differential' => 6, 'point_differential_per_game' => '0.1', 'streak_type' => 'loss', 'streak_total' => 1, 'games_played' => 71 }, { 'rank' => 3, 'won' => 34, 'lost' => 37, 'streak' => 'L1', 'ordinal_rank' => '3rd', 'first_name' => 'New York', 'last_name' => 'Mets', 'team_id' => 'new-york-mets', 'games_back' => 7.5, 'points_for' => 334, 'points_against' => 353, 'home_won' => 20, 'home_lost' => 14, 'away_won' => 14, 'away_lost' => 23, 'conference_won' => 30, 'conference_lost' => 34, 'division_won' => 18, 'division_lost' => 13, 'last_five' => '2-3', 'last_ten' => '5-5', 'conference' => 'NL', 'division' => 'E', 'points_scored_per_game' => '4.7', 'points_allowed_per_game' => '5.0', 'win_percentage' => '.479', 'point_differential' => -19, 'point_differential_per_game' => '-0.3', 'streak_type' => 'loss', 'streak_total' => 1, 'games_played' => 71 }, { 'rank' => 4, 'won' => 33, 'lost' => 38, 'streak' => 'W1', 'ordinal_rank' => '4th', 'first_name' => 'Washington', 'last_name' => 'Nationals', 'team_id' => 'washington-nationals', 'games_back' => 8.5, 'points_for' => 352, 'points_against' => 351, 'home_won' => 17, 'home_lost' => 17, 'away_won' => 16, 'away_lost' => 21, 'conference_won' => 30, 'conference_lost' => 37, 'division_won' => 15, 'division_lost' => 15, 'last_five' => '2-3', 'last_ten' => '5-5', 'conference' => 'NL', 'division' => 'E', 'points_scored_per_game' => '5.0', 'points_allowed_per_game' => '4.9', 'win_percentage' => '.465', 'point_differential' => 1, 'point_differential_per_game' => '0.0', 'streak_type' => 'win', 'streak_total' => 1, 'games_played' => 71 }, { 'rank' => 5, 'won' => 25, 'lost' => 44, 'streak' => 'L1', 'ordinal_rank' => '5th', 'first_name' => 'Miami', 'last_name' => 'Marlins', 'team_id' => 'miami-marlins', 'games_back' => 15.5, 'points_for' => 240, 'points_against' => 316, 'home_won' => 13, 'home_lost' => 25, 'away_won' => 12, 'away_lost' => 19, 'conference_won' => 20, 'conference_lost' => 40, 'division_won' => 9, 'division_lost' => 22, 'last_five' => '2-3', 'last_ten' => '2-8', 'conference' => 'NL', 'division' => 'E', 'points_scored_per_game' => '3.5', 'points_allowed_per_game' => '4.6', 'win_percentage' => '.362', 'point_differential' => -76, 'point_differential_per_game' => '-1.1', 'streak_type' => 'loss', 'streak_total' => 1, 'games_played' => 69 }, { 'rank' => 1, 'won' => 47, 'lost' => 24, 'streak' => 'L1', 'ordinal_rank' => '1st', 'first_name' => 'Los Angeles', 'last_name' => 'Dodgers', 'team_id' => 'los-angeles-dodgers', 'games_back' => 0.0, 'points_for' => 368, 'points_against' => 258, 'home_won' => 27, 'home_lost' => 8, 'away_won' => 20, 'away_lost' => 16, 'conference_won' => 46, 'conference_lost' => 21, 'division_won' => 17, 'division_lost' => 7, 'last_five' => '2-3', 'last_ten' => '5-5', 'conference' => 'NL', 'division' => 'W', 'points_scored_per_game' => '5.2', 'points_allowed_per_game' => '3.6', 'win_percentage' => '.662', 'point_differential' => 110, 'point_differential_per_game' => '1.5', 'streak_type' => 'loss', 'streak_total' => 1, 'games_played' => 71 }, { 'rank' => 2, 'won' => 37, 'lost' => 34, 'streak' => 'L1', 'ordinal_rank' => '2nd', 'first_name' => 'Colorado', 'last_name' => 'Rockies', 'team_id' => 'colorado-rockies', 'games_back' => 10.0, 'points_for' => 405, 'points_against' => 393, 'home_won' => 22, 'home_lost' => 15, 'away_won' => 15, 'away_lost' => 19, 'conference_won' => 30, 'conference_lost' => 30, 'division_won' => 13, 'division_lost' => 12, 'last_five' => '2-3', 'last_ten' => '5-5', 'conference' => 'NL', 'division' => 'W', 'points_scored_per_game' => '5.7', 'points_allowed_per_game' => '5.5', 'win_percentage' => '.521', 'point_differential' => 12, 'point_differential_per_game' => '0.2', 'streak_type' => 'loss', 'streak_total' => 1, 'games_played' => 71 }, { 'rank' => 3, 'won' => 38, 'lost' => 35, 'streak' => 'L1', 'ordinal_rank' => '3rd', 'first_name' => 'Arizona', 'last_name' => 'Diamondbacks', 'team_id' => 'arizona-diamondbacks', 'games_back' => 10.0, 'points_for' => 384, 'points_against' => 326, 'home_won' => 14, 'home_lost' => 16, 'away_won' => 24, 'away_lost' => 19, 'conference_won' => 29, 'conference_lost' => 31, 'division_won' => 11, 'division_lost' => 19, 'last_five' => '3-2', 'last_ten' => '7-3', 'conference' => 'NL', 'division' => 'W', 'points_scored_per_game' => '5.3', 'points_allowed_per_game' => '4.5', 'win_percentage' => '.521', 'point_differential' => 58, 'point_differential_per_game' => '0.8', 'streak_type' => 'loss', 'streak_total' => 1, 'games_played' => 73 }, { 'rank' => 4, 'won' => 35, 'lost' => 37, 'streak' => 'W1', 'ordinal_rank' => '4th', 'first_name' => 'San Diego', 'last_name' => 'Padres', 'team_id' => 'san-diego-padres', 'games_back' => 12.5, 'points_for' => 315, 'points_against' => 353, 'home_won' => 18, 'home_lost' => 20, 'away_won' => 17, 'away_lost' => 17, 'conference_won' => 30, 'conference_lost' => 34, 'division_won' => 16, 'division_lost' => 17, 'last_five' => '2-3', 'last_ten' => '4-6', 'conference' => 'NL', 'division' => 'W', 'points_scored_per_game' => '4.4', 'points_allowed_per_game' => '4.9', 'win_percentage' => '.486', 'point_differential' => -38, 'point_differential_per_game' => '-0.5', 'streak_type' => 'win', 'streak_total' => 1, 'games_played' => 72 }, { 'rank' => 5, 'won' => 30, 'lost' => 39, 'streak' => 'L1', 'ordinal_rank' => '5th', 'first_name' => 'San Francisco', 'last_name' => 'Giants', 'team_id' => 'san-francisco-giants', 'games_back' => 16.0, 'points_for' => 266, 'points_against' => 348, 'home_won' => 15, 'home_lost' => 21, 'away_won' => 15, 'away_lost' => 18, 'conference_won' => 24, 'conference_lost' => 32, 'division_won' => 14, 'division_lost' => 16, 'last_five' => '4-1', 'last_ten' => '5-5', 'conference' => 'NL', 'division' => 'W', 'points_scored_per_game' => '3.9', 'points_allowed_per_game' => '5.0', 'win_percentage' => '.435', 'point_differential' => -82, 'point_differential_per_game' => '-1.2', 'streak_type' => 'loss', 'streak_total' => 1, 'games_played' => 69 }] }
    # rubocop:enable Metrics/LineLength
    @twins = Leaderbrag::Team.new('minnesota-twins', @standings)
  end

  it 'the twins exist' do
    expect(@twins).not_to be_nil
  end

  it 'the twins are winning the division' do
    expect(@twins.division_leader?).to be true
  end

  it 'the twins are the best in the AL' do
    expect(@twins.league_leader?).to be true
  end

  it 'the twins are the best team in baseball' do
    expect(@twins.overall_leader?).to be true
  end
end