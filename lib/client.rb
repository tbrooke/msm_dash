require 'httparty'

module Msm
  class Client
    include HTTParty
    base_uri = 'localhost:3000'


    def self.household
      get('/households.json').parsed_response
    end

    def self.summary
      get("/summary.json").parsed_response
    end

    def self.visit
      get("/visits.json").parsed_response
    end

    def self.donor
      get("/donors.json").parsed_response
    end

    def self.volunteer
      get("/volunteers.json").parsed_response
    end


  end
end
