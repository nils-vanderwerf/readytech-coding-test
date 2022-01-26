class GetPurchaseItems

    attr_accessor :shopping_basket

    def initialize
        @shopping_basket = []
    end 

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
        path = input
        if File.exist?(path)
            puts ""
            puts "File Found"
            puts ""
            @shopping_basket = ShoppingBasket.new(path).read_data
            confirm_order
        elsif input != 'quit'
            puts "Oops! We couldn't find this file. Please try again."
        end
    end

    def confirm_order
        puts @shopping_basket
        confirmation = nil
        puts "Confirm order? Y/N"
        confirmation = gets.strip.downcase
        if confirmation === "y"
            puts "Loading receipt"
            generate_receipt
        elsif confirmation === "n"
            puts "Ok, lets try again. Please enter the path for your shopping cart file"
            user_input
        else 
            puts "Invalid input"
        end

    end

    def generate_receipt
        parsed_data = CSV.parse(@shopping_basket)
        puts "PARSED: #{parsed_data}"
        receipt = Receipt.new(@shopping_basket)
        receipt.csv_export
    end

end