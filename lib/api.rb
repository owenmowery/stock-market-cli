class API

    def self.load_stocks
    
        resp = RestClient.get("http://api.marketstack.com/v1/tickers?access_key=#{ENV['API_KEY']}")
        stock_market_hash = JSON.parse(resp.body, symbolize_names: true)
        stock_market_array = stock_market_hash[:data]

        stocks = stock_market_array.collect do |stock|
            Stock.new(stock)
        end 
    end

    def self.load_stock_details(ticker, input)
        resp = RestClient.get("http://api.marketstack.com/v1/eod?access_key=#{ENV['API_KEY']}&symbols=#{ticker}")
        stock_hash = JSON.parse(resp.body, symbolize_names: true)
        stock_array = stock_hash[:data]
        current_stock = Stock.all.find {|stock| stock.symbol == ticker}
        current_stock.open_price = stock_array[0][:open]
        current_stock.close_price = stock_array[0][:close]
        current_stock.volume = stock_array[0][:volume]
        current_stock.date = stock_array[0][:date]


        CLI.current(current_stock, input.to_i)
    end
end 





