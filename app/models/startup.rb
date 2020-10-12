

require 'pry'


class Startup
    attr_accessor :name, :domain
    attr_reader :founder
    @@all =[]
  
    def initialize(name, founder, domain)
        @name = name 
        @founder = founder
        @domain = domain
  
        @@all << self
    end
  
    def pivot(domain, name)
  
        @domain = domain
        @name = name
    end
  
    def self.all
        @@all
    end
  
    def self.find_by_founder(founder)
      Startup.all.find do |startup|
        startup.founder == founder
      end
    
    end
  
    def self.domains
      domains = []
      Startup.all.map do |startup|
        domains << startup.domain
      end
      domains
    end
   #given a venture capitalist object, type of investment (as a string), and the amount invested (as a float), creates a new funding round and associates it with that startup and venture capitalist.
  
    def sign_contract(venture_capitalist, type, investment)
    FundingRound.new(self, venture_capitalist, type, investment)
    end
  
    def num_funding_rounds
      FundingRound.all.count do |round|
        round.startup == self
      end
    end
  
    def total_funds
      @total = []
      FundingRound.all.select do |round|
        if round.startup == self
       @total << round.investment
      end
    end
      @total.sum
    end
  
    def investors
      @investors = []
      FundingRound.all.select do |round|
        if round.startup == self
          @investors << round.venture_capitalist.name
        end
      end
      @investors.uniq
    end
  
    def big_investors
      @big_investors = []
    self.investors.detect do |firm|
      if VentureCapitalist.tres_commas_club.include?(firm.name)
        @big_investors << firm.name
      end
  
        end
    @big_investors.uniq
    end
  
  
  end