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

Use the `find` task to find the best team in baseball:

```
$ leader find
The Minnesota Twins are the leaders of the AL C division.
The Minnesota Twins are the leaders of the AL.
The Minnesota Twins are the best team in baseball.
```

To query about a specific team, you'll need that team's ID. Get the full leaderboard with the `board` task, which includes each team's ID:
```
$ leader board
Team Name              Team ID               Rank  Win%  League  Div
--------------------------------------------------------------------
Los Angeles Dodgers:   los-angeles-dodgers   1     .671  NL      W
Minnesota Twins:       minnesota-twins       2     .649  AL      C
New York Yankees:      new-york-yankees      3     .635  AL      E
Houston Astros:        houston-astros        4     .632  AL      W
Atlanta Braves:        atlanta-braves        5     .587  NL      E
Tampa Bay Rays:        tampa-bay-rays        6     .573  AL      E
Chicago Cubs:          chicago-cubs          7     .547  NL      C
Colorado Rockies:      colorado-rockies      8     .541  NL      W
Boston Red Sox:        boston-red-sox        9     .539  AL      E
Texas Rangers:         texas-rangers         10    .533  AL      W
Milwaukee Brewers:     milwaukee-brewers     11    .533  NL      C
Cleveland Indians:     cleveland-indians     12    .527  AL      C
Philadelphia Phillies: philadelphia-phillies 13    .527  NL      E
Oakland Athletics:     oakland-athletics     14    .526  AL      W
St. Louis Cardinals:   st-louis-cardinals    15    .514  NL      C
San Diego Padres:      san-diego-padres      16    .507  NL      W
Arizona Diamondbacks:  arizona-diamondbacks  17    .500  NL      W
Los Angeles Angels:    los-angeles-angels    18    .500  AL      W
Chicago White Sox:     chicago-white-sox     19    .486  AL      C
Washington Nationals:  washington-nationals  20    .486  NL      E
Cincinnati Reds:       cincinnati-reds       21    .479  NL      C
New York Mets:         new-york-mets         22    .474  NL      E
Pittsburgh Pirates:    pittsburgh-pirates    23    .452  NL      C
San Francisco Giants:  san-francisco-giants  24    .425  NL      W
Seattle Mariners:      seattle-mariners      25    .418  AL      W
Detroit Tigers:        detroit-tigers        26    .371  AL      C
Miami Marlins:         miami-marlins         27    .370  NL      E
Toronto Blue Jays:     toronto-blue-jays     28    .360  AL      E
Kansas City Royals:    kansas-city-royals    29    .347  AL      C
Baltimore Orioles:     baltimore-orioles     30    .280  AL      E
```
When asking about a team, the exit code is 0 when the requested team is the best team in baseball, otherwise it is the rank of that team in their division.
```
$ leader is minnesota-twins
The Minnesota Twins are the leaders of the AL C division.
The Minnesota Twins are the leaders of the AL.
The Minnesota Twins are the best team in baseball.
$ echo $?
0
$ leader is new-york-yankees
The New York Yankees are the leaders of the AL E division.
The New York Yankees are not the leaders of the AL. They are #2.
The New York Yankees are not the best team in baseball. They are #3.
$ echo $?
1
$ leader is seattle-mariners
The Seattle Mariners are not the leaders of the AL W division. They are 5th.
The Seattle Mariners are not the leaders of the AL. They are #11.
The Seattle Mariners are not the best team in baseball. They are #25.
$ echo $?
5
```
You can also get some extra stats about the team in the `is` and `find` tasks with the `-s` option:
```
$ leader is chicago-cubs -s
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

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 

There are a few rake tasks defined for linting and testing. The default rake task runs them all. Before submitting a pull request, please ensure tests and style checks pass.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/schlazor/leaderbrag. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Leaderbrag project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/schlazor/leaderbrag/blob/master/CODE_OF_CONDUCT.md).
