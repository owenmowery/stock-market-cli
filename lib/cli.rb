class CLI

    def call

        #clear stock instances
        Stock.clear
        
        #load in stocks into stock class using api
        API.load_stocks

        #greet user
        puts "📈📊-----Welcome to the NYSE Stock Tracker-----📊📈"
        puts

        #get stock ticker 
        get_input


    end

    def get_input
        puts "🚀🚀-----Enter a stock ticker (ex. AAPL, TSLA): "
        ticker_input = gets.chomp.upcase
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
        puts "| 1. Open Price  💵 |".green
        puts
        puts "| 2. Close Price 💵 |".green
        puts
        puts "| 3. Volume      📊 |".green
        puts
        puts "| 4. Index       🗂  |".green
        puts
        puts "| 5. Date        ⌚️ |".green
        puts
    end



    def self.current(current_stock, input)
        if input == 1
            puts "| The opening price of #{current_stock.name} was $#{current_stock.open_price}".green
        elsif input == 2
            puts "| The closing price of #{current_stock.name} was $#{current_stock.close_price}".green
        elsif input == 3
            puts "| The total volume of #{current_stock.name} was #{current_stock.volume}".green
        elsif input == 4
            puts "| #{current_stock.name} is in is the #{current_stock.index}".green
        else
            puts "| This data for #{current_stock.name} is from #{current_stock.date}.".green
        end

        continue(current_stock)

    end

    def self.continue(current_stock)
        puts "| Would you like to access another piece of data from #{current_stock.name}? (Y or N)"
        choice = gets.chomp

        if choice.upcase == "Y"
            CLI.new.menu(current_stock.symbol)
        elsif choice.upcase == "N"
            puts "| Would you like to pick a different stock to view? (Y or N)"
            input = gets.chomp
            
            if input.upcase == "Y"
                CLI.new.call
            else
                puts "Happy Trading!"
            end
        else
            puts "Please enter Y or N."
            continue(current_stock)
        end

        
    end
end