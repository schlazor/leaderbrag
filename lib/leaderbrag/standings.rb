# frozen_string_literal: true

require 'json'
require 'net/http'

module Leaderbrag
  # holds the current baseball standings
  class Standings
    attr_reader :standings

    def initialize
      update
    end

    def update
      url = 'https://erikberg.com/mlb/standings.json'
      uri = URI(url)
      user_agent = 'Leaderbrag/0.1.0 (david@schdav.org)'
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = Net::HTTP::Get.new(uri, 'User-Agent' => user_agent)
        response = http.request(request)
        @standings = JSON.parse(response.body)
      end
    end
  end
end
