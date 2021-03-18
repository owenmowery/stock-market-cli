class Stock

    attr_accessor :name, :symbol, :open_price, :close_price, :volume, :index, :date

    @@all = []

    def initialize(stock)
        @name = stock[:name]
        @symbol = stock[:symbol]
        @index = stock[:stock_exchange][:name]
        @open_price = open_price
        @close_price = close_price
        @volume = volume
        @date = date
        @@all << self
    end

    def self.all
        @@all
    end
end