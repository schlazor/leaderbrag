Feature: leader is
  In order to determine if a team is currently leading all of baseball, their division or their league
  As a CLI
  I will run `leader is` which queries xmlstats to find out

  Scenario: I think the Minnesota Twins are the best team in baseball.
    When I run `leader is minnesota-twins`
    Then the output should match /The Minnesota Twins are (not )?the best team in baseball./