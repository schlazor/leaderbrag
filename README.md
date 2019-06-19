# Leaderbrag

Leaderbrag is a small gem that uses [xmlstats](https://erikberg.com/api) to find the leading team in baseball or determine if a given team is the best in baseball. 

It includes the CLI executable `leader` which should be suitable for most scripting desires and also serves as a useful example for using the underlying library.

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

Using the CLI is pretty straightforward. Use the `find` task to find the best team in baseball:

```
$ leader find
The Minnesota Twins are the leaders of the AL C division.
The Minnesota Twins are the leaders of the AL.
The Minnesota Twins are the best team in baseball.
```

To query about a specific team, you'll need that team's ID. Get the list with the `list` task:
```
$ leader list
Minnesota Twins:       minnesota-twins
Cleveland Indians:     cleveland-indians
Chicago White Sox:     chicago-white-sox
Detroit Tigers:        detroit-tigers
Kansas City Royals:    kansas-city-royals
New York Yankees:      new-york-yankees
Tampa Bay Rays:        tampa-bay-rays
Boston Red Sox:        boston-red-sox
Toronto Blue Jays:     toronto-blue-jays
Baltimore Orioles:     baltimore-orioles
Houston Astros:        houston-astros
Texas Rangers:         texas-rangers
Oakland Athletics:     oakland-athletics
Los Angeles Angels:    los-angeles-angels
Seattle Mariners:      seattle-mariners
Milwaukee Brewers:     milwaukee-brewers
Chicago Cubs:          chicago-cubs
St. Louis Cardinals:   st-louis-cardinals
Cincinnati Reds:       cincinnati-reds
Pittsburgh Pirates:    pittsburgh-pirates
Atlanta Braves:        atlanta-braves
Philadelphia Phillies: philadelphia-phillies
New York Mets:         new-york-mets
Washington Nationals:  washington-nationals
Miami Marlins:         miami-marlins
Los Angeles Dodgers:   los-angeles-dodgers
Colorado Rockies:      colorado-rockies
Arizona Diamondbacks:  arizona-diamondbacks
San Diego Padres:      san-diego-padres
San Francisco Giants:  san-francisco-giants
```
When asking about a team, the exit code indicates whether the requested team is the best team in baseball - 0 of so, otherwise it is the rank of that team in their division.
```
$ leader is minnesota-twins
The Minnesota Twins are the leaders of the AL C division.
The Minnesota Twins are the leaders of the AL.
The Minnesota Twins are the best team in baseball.
$ echo $?
0

$ leader is new-york-yankees
The New York Yankees are the leaders of the AL E division.
The New York Yankees are not the leaders of the AL.
The New York Yankees are not the best team in baseball.
$ echo $?
1

$ leader is seattle-mariners
The Seattle Mariners are not the leaders of the AL W division.
The Seattle Mariners are not the leaders of the AL.
The Seattle Mariners are not the best team in baseball.
$ echo $?
5
```
You can also get some extra stats about the team in the `is` and `find` tasks:
```
$ leader is new-york-yankees -s
Rank:                          1
Won:                           44
Lost:                          27
Streak:                        W3
Games back:                    0.0
Points for:                    382
Points against:                307
Home won:                      23
Home lost:                     13
Away won:                      21
Away lost:                     14
Conference won:                38
Conference lost:               23
Division won:                  20
Division lost:                 7
Last five:                     3-2
Last ten:                      5-5
Conference:                    AL
Division:                      E
Points scored per game:        5.4
Points allowed per game:       4.3
Win percentage:                .620
Point differential:            75
Point differential per game:   1.1
Streak type:                   win
Streak total:                  3
Games played:                  71
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 

There are a few rake tasks defined for linting and testing. The default rake task runs them all. Before submitting a pull request, please ensure tests and style checks pass.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/schlazor/leaderbrag. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Leaderbrag project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/schlazor/leaderbrag/blob/master/CODE_OF_CONDUCT.md).
