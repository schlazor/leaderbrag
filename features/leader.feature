Feature: Leader
  In order to determine if a team is currently leading all of baseball
  As a CLI
  I will query xmlstats to find out

  Scenario: Tell me if the Minnesota Twins are the best team in baseball.
    When I run `leader is minnesota-twins`
    Then the output should match /The Minnesota Twins are (not )?the best team in baseball./

  Scenario: I need a list of team IDs.
    When I run `leader list`
    Then the output should contain "kansas-city-royals"
  
  Scenario: I want to know who the best team in baseball is.
    When I run `leader find`
    Then the output should match /The .* are the best team in baseball./