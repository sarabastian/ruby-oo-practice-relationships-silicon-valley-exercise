require_relative '../config/environment.rb'
require 'pry'

def reload
  load 'config/environment.rb'
end


s1 = Startup.new("neuo", "eric", "neuo.io")
s2 = Startup.new("goop", "GP", "goop.com")
s3 = Startup.new("scott's tots", "Michael Scott", "scottstots.com")

vc1 = VentureCapitalist.new("canaras", 1000100000)
vc2 = VentureCapitalist.new("ares", 300)
vc3 = VentureCapitalist.new("goldman", 500000000000)

FR1 = FundingRound.new(s1, vc2, "Angel", 500)
FR2 = FundingRound.new(s3, vc3, "Pre-Seed", 300)
FR3 = FundingRound.new(s2, vc2, "Series A", 1000)
FR4 = FundingRound.new(s1, vc1, "Series B", 600)
FR5 = FundingRound.new(s3, vc3, "Angel", 800)

 
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



class VentureCapitalist

  attr_accessor :name, :worth 
  @@all = []

  def initialize(name, worth)
      @name = name
      @worth = worth

      @@all << self
  end

  def total_worth
    @worth
  end 

  def self.all
      @@all
  end

  def self.tres_commas_club
     @club = []
      VentureCapitalist.all.map do |firm|
      if firm.worth > 1000000000
      @club << firm.name
      end
    end
    @club
  end

  def offer_contract(startup, type, investment)
    FundingRound.new(startup, self, type, investment)
  end

  def funding_rounds
    @total = []
    FundingRound.all.collect do |round|
      if round.venture_capitalist == self
      @total << round.investment
      end
    end
    @total.sum
  end

  def portfolio
    @startups = []
    FundingRound.all.collect do |round|
      if round.venture_capitalist == self
        @startups << round.startup.name
      end
    end
    @startups.uniq
  end

  def biggest_investment
    @big = []
    FundingRound.all.collect do |round|
      if round.venture_capitalist == self
        @big << round.investment
      end
    end
    @big.max 
    
  end

  def invested(domain)
    @domaintotal = []
    if Startup.domains.include?(domain)
    FundingRound.all.map do |round|
      if round.venture_capitalist == self 
       @domaintotal << round.investment
      end
    end
  end
  @domaintotal.sum
  end
  
end


class FundingRound

  attr_accessor :type, :investment
  attr_reader :startup, :venture_capitalist
  @@all = []

  def initialize(startup, venture_capitalist, type, investment)
      @startup = startup
      @venture_capitalist = venture_capitalist
      @type = type
      @investment = investment

      @@all << self
  end
  
  def self.all
      @@all
  end
end



# Insert code here to run before hitting the binding.pry
# This is a convenient place to define variables and/or set up new object instances,
# so they will be available to test and play around with in your console

binding.pry
0 #leave this here to ensure binding.pry isn't the last line

  

