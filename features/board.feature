Feature: leader board
  In order to get a ranked list of baseball teams
  As a CLI
  I will run `leader board` which queries xmlstats
  
  Scenario: I need a list of all the baseball teams ordered by win percentage.
    When I run `leader board`
    Then the output should contain " 30 "
  
  Scenario: I need a list of all the baseball teams in the NL ordered by win percentage.
    When I run `leader board -L NL`
    Then the output should not contain "AL    1"

  Scenario: I need a list of all the baseball teams in the AL E ordered by win percentage.
    When I run `leader board -L AL -D E`
    Then the output should not contain "AL    \d{1,2}?     W   1"
  
 