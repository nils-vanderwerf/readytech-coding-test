class GetPurchaseItems
    def call
        puts ""
        puts "======================"
        puts ""
        puts "WELCOME"
        puts "Let us create a receipt for your shopping cart"
        
        puts ""
        user_input
    end

    def user_input
        # Input is path of shopping cart file
        puts "Please enter the path for your shopping cart file"
        input = nil
        while input != "quit"
            input = gets.strip
            #Check if file path exists
            check_filepath(input)
        end
    end

    def check_filepath(input)
        if File.exist?(input)
            puts ""
            puts "File Found"
            puts ""
            shopping_basket = ShoppingBasket.new(input)
            puts shopping_basket.read_data
            puts "" 
            confirm_order
        elsif input != 'quit'
            puts "Oops! We couldn't find this file. Please try again."
        end
    end

    def confirm_order
        confirmation = nil
        puts "Confirm order? Y/N"
        confirmation = gets.strip.downcase
        if confirmation === "y"
            puts "Loading receipt"
        elsif confirmation === "n"
            puts "Ok, lets try again. Please enter the path for your shopping cart file"
            user_input
        else 
            puts "Invalid input"
        end

    end

end