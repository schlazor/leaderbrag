Feature: Leader
  In order to determine if a team is currently leading all of baseball
  As a CLI
  I will query xmlstats to find out

  Scenario: The think the minnesota twins are the best team in baseball.
    When I run `leader is minnesota-twins`
    Then the output should contain "The Minnesota Twins are the best team in baseball."
  
  Scenario: The think the new york yankees are not the best team in baseball.
    When I run `leader is new-york-yankees`
    Then the output should contain "The New York Yankees are not the best team in baseball."

  Scenario: I need a list of team IDs.
    When I run `leader list`
    Then the output should contain "kansas-city-royals"
  
  Scenario: I want to know who the best team in baseball is.
    When I run `leader find`
    Then the output should contain "The Minnesota Twins are the best team in baseball."