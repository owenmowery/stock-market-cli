class CLI

    def call

        #load in stocks into stock class using api
        API.load_stocks

        #greet user
        puts "Welcome to the New York Stock Exchange Stock Tracker"

        #tell them to enter a stock symbol
        puts "Enter a stock ticker (ex. AAPL, TSLA): "
        ticker_input = gets.chomp

        menu(ticker_input)


    end

    def menu(ticker_input)
        list_options
        puts "Please select a number to access that piece of data:"
        input = gets.chomp

        if !input.to_i.between?(1, 5)
            puts "Enter a valid number."
            list_options
            menu(ticker_input)
        else
            API.load_stock_details(ticker_input, input)
        end
    end

    def list_options
        puts "1. Open Price"
        puts "2. Close Price"
        puts "3. Volume"
        puts "4. Index"
        puts "5. Date"
    end

    def self.current(current_stock, input)
        if input == 1
            puts "The open price of #{current_stock.name} is $#{current_stock.open_price}"
        elsif input == 2
            puts "The close price of #{current_stock.name} is $#{current_stock.close_price}"
        elsif input == 3
            puts "The total volume of #{current_stock.name} is #{current_stock.volume}"
        elsif input == 4
            puts "#{current_stock.name} is in is the #{current_stock.index}"
        else
            puts "This data for #{current_stock.name} is from #{current_stock.date}."
        end

        continue(current_stock)

    end

    def self.continue(current_stock)
        puts "Would you like to access another piece of data from #{current_stock.name}? (Y or N)"
        choice = gets.chomp

        if choice.upcase == "Y"
            CLI.new.menu(current_stock.symbol)
        else
            puts "Goodbye!"
        end

        
    end
end