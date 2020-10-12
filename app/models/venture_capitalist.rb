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