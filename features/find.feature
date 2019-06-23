Feature: leader find
  In order to determine which team is currently leading all of baseball, a division or a league
  As a CLI
  I will run `leader find` which queries xmlstats to find out

  Scenario: I want to know who the best team in baseball is.
    When I run `leader find`
    Then the output should match /The .* are the best team in baseball./
  
  Scenario: I want to know who the best team in the AL is.
    When I run `leader find -l AL`
    Then the output should match /The .* are the leaders of the AL./

  Scenario: I want to know who the best team in the NL E is.
    When I run `leader find -l NL -d E`
    Then the output should match /The .* are the leaders of the NL E division./

  