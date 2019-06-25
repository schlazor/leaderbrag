# Leaderbrag [![Build Status](https://travis-ci.org/schlazor/leaderbrag.svg?branch=master)](https://travis-ci.org/schlazor/leaderbrag)

Leaderbrag is a small gem that uses [xmlstats](https://erikberg.com/api) via [xmlstats-ruby](https://github.com/alexmchale/xmlstats-ruby) to find the leading team in baseball or determine if a given team is the best in baseball.

It includes the CLI executable `leader` which should be suitable for most scripting desires.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'leaderbrag'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install leaderbrag

## Usage

First, ensure you have $GEM_HOME/bin in your path.
You'll need to set some environment variables to match your [xmlstats API key](https://erikberg.com/api#):
```
$ export XMLSTATS_API_KEY="xxxxx-xxxx-xxxx"
$ export XMLSTATS_CONTACT_INFO="you@example.com"
```
To cut down on API calls, you can turn on caching by setting these environment variables:
```
export XMLSTATS_CACHER='redis'
export XMLSTATS_REDIS_HOST='127.0.0.1'
```
where XMLSTATS_REDIS_HOST is the IP of a server running [redis](https://redis.io/) that you have access to. Most probably this is `127.0.0.1` and in fact if you don't specify this environment variable that value will be used.

Using the CLI is pretty straightforward.

All tasks accept the `--date` option which expects a date in `yyyyMMdd` format and will cause the results to reflect the given date.

### leader find
Use the `find` task to find the best team in baseball:

```
$ leader find --date 20190618
On the 18th day of June, 2019:
The Minnesota Twins are the leaders of the AL C division.
The Minnesota Twins are the leaders of the AL.
The Minnesota Twins are the best team in baseball.
```
You can also get some extra team stats with the `-s` option, and find the best team in a league or division. `leader -h find` provides the details:
```
$ leader -h find
Usage:
  leader find

Options:
  -s, [--stats=STATS]        # Include team stats in output.
  -l, [--league=LEAGUE]      # Find the league leader rather than overall best team.
                             # Possible values: AL, NL
  -d, [--division=DIVISION]  # Find the division leader rather than overall best team. Requires use of --league.
                             # Possible values: E, C, W
      [--date=DATE]          # The date for which to retrieve statistics. 'yyyyMMdd' format; default is current date. Statistics exist starting with the 2008 season.

Finds the best team in all of baseball, a league or a division.
```

### leader board
To query about a specific team, you'll need that team's ID. Get the full leaderboard with the `board` task, which includes each team's ID:
```
$ leader board
Team ID               Win%   W   L  Rank  League Rank  Div Rank   GB   Streak
-----------------------------------------------------------------------------
los-angeles-dodgers   .684  54  25   1      NL     1    W    1    0.0    W6
minnesota-twins       .649  50  27   2      AL     1    C    1    0.0    L1
new-york-yankees      .636  49  28   3      AL     2    E    1    0.0    L1
houston-astros        .620  49  30   4      AL     3    W    1    0.0    W1
atlanta-braves        .590  46  32   5      NL     2    E    1    0.0    W2
tampa-bay-rays        .577  45  33   6      AL     4    E    2    4.5    W1
cleveland-indians     .545  42  35   7      AL     5    C    2    8.0    W3
chicago-cubs          .545  42  35   8      NL     3    C    1    0.0    W1
texas-rangers         .538  42  36   9      AL     6    W    2    6.5    W2
milwaukee-brewers     .538  42  36  10      NL     4    C    2    0.5    W2
boston-red-sox        .532  42  37  11      AL     7    E    3    8.0    L2
oakland-athletics     .519  41  38  12      AL     8    W    3    8.0    L1
colorado-rockies      .519  40  37  13      NL     5    W    2   13.0    L3
st-louis-cardinals    .519  40  37  14      NL     6    C    3    2.0    L1
philadelphia-phillies .506  39  38  15      NL     7    E    2    6.5    L7
los-angeles-angels    .494  39  40  16      AL     9    W    4   10.0    W1
arizona-diamondbacks  .494  39  40  17      NL     8    W    3   15.0    W1
san-diego-padres      .487  38  40  18      NL     9    W    4   15.5    L3
washington-nationals  .481  37  40  19      NL    10    E    3    8.5    L2
chicago-white-sox     .480  36  39  20      AL    10    C    3   13.0    L2
cincinnati-reds       .474  36  40  21      NL    11    C    4    5.5    L2
new-york-mets         .474  37  41  22      NL    12    E    4    9.0    L1
pittsburgh-pirates    .474  36  40  23      NL    13    C    4    5.5    W4
san-francisco-giants  .434  33  43  24      NL    14    W    5   19.5    L1
seattle-mariners      .427  35  47  25      AL    11    W    5   15.5    W1
miami-marlins         .395  30  46  26      NL    15    E    5   15.0    W4
toronto-blue-jays     .372  29  49  27      AL    12    E    4   20.5    W2
detroit-tigers        .356  26  47  28      AL    13    C    4   22.0    L4
kansas-city-royals    .346  27  51  29      AL    14    C    5   23.5    W1
baltimore-orioles     .282  22  56  30      AL    15    E    5   27.5    L1
```
You can also sort and filter by league and division. Use `leader -h board` for details:
```
$ leader -h board
Usage:
  leader board

Options:
  -l, [--sort-by-league], [--no-sort-by-league]      # Sort by league.
  -L, [--only-league=ONLY_LEAGUE]                    # Only show results for this league.
                                                     # Possible values: AL, NL
  -d, [--sort-by-division], [--no-sort-by-division]  # Sort by league and division. Supercedes -l.
  -D, [--only-division=ONLY_DIVISION]                # Only show results for this division.
                                                     # Possible values: E, C, W
      [--date=DATE]                                  # The date for which to retrieve statistics. 'yyyyMMdd' format; default is current date. Statistics exist starting with the 2008 season.

Lists baseball teams with their standings.
```
### leader is

Use the `is` task to determine if your favorite team is leading baseball. If it is, the exit code is 0. If not, the exit code is that team's current rank in their division.
```
$ leader is minnesota-twins
Today, the 18th day of June, 2019:
The Minnesota Twins are the leaders of the AL C division.
The Minnesota Twins are the leaders of the AL.
The Minnesota Twins are the best team in baseball.
$ echo $?
0
$ leader is new-york-yankees
Today, the 18th day of June, 2019:
The New York Yankees are the leaders of the AL E division.
The New York Yankees are not the leaders of the AL. They are #2.
The New York Yankees are not the best team in baseball. They are #3.
$ echo $?
1
$ leader is seattle-mariners
Today, the 18th day of June, 2019:
The Seattle Mariners are not the leaders of the AL W division. They are 5th.
The Seattle Mariners are not the leaders of the AL. They are #11.
The Seattle Mariners are not the best team in baseball. They are #25.
$ echo $?
5
```
You can also get some extra team stats with the `-s` option:
```
$ leader is chicago-cubs -s
Today, the 18th day of June, 2019:
The Chicago Cubs are the leaders of the NL C division.
The Chicago Cubs are not the leaders of the NL. They are #3.
The Chicago Cubs are not the best team in baseball. They are #7.
Rank:                         1
Won:                          41
Lost:                         34
Streak:                       L1
Games back:                   0.0
Points for:                   382
Points against:               317
Home won:                     26
Home lost:                    13
Away won:                     15
Away lost:                    21
Conference won:               34
Conference lost:              28
Division won:                 13
Division lost:                11
Last five:                    2-3
Last ten:                     4-6
Conference:                   NL
Division:                     C
Points scored per game:       5.1
Points allowed per game:      4.2
Win percentage:               .547
Point differential:           65
Point differential per game:  0.9
Streak type:                  loss
Streak total:                 1
Games played:                 75
Date:                         2019-06-21
```
You can also limit your query to their league or division with the `-l` and `-d` options. Full help:
```
$ leader -h is minnesota-twins
Usage:
  leader is TEAM

Options:
  -q, [--quiet], [--no-quiet]        # Do not print results
  -s, [--stats], [--no-stats]        # Include team stats in output
  -l, [--league], [--no-league]      # Check leadership of team's league. Only affects exit code.
  -d, [--division], [--no-division]  # Check leadership of team's division.Only affects the exit code.
      [--date=DATE]                  # The date for which to retrieve statistics. 'yyyyMMdd' format; default is current date. Statistics exist starting with the 2008 season.

Asserts that TEAM is the best team in baseball.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 

There are a few rake tasks defined for linting and testing. The default rake task runs them all. Before submitting a pull request, please ensure tests and style checks pass.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/schlazor/leaderbrag. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Leaderbrag project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/schlazor/leaderbrag/blob/master/CODE_OF_CONDUCT.md).
