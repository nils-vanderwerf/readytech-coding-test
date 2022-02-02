class CLI

    attr_accessor :shopping_basket, :output

    def initialize(stdout=STDOUT)
        @stdout = stdout
        @shopping_basket = []
        @output = []
    end 

    def call
        @stdout.puts ""
        @stdout.puts "======================"
        @stdout.puts ""
        @stdout.puts "WELCOME"
        @stdout.puts "Let us create a receipt for your shopping cart"
        @stdout.puts ""
        user_input
    end 

    def user_input
        # Input is path of shopping cart file
         #reset line items class values to 0, so they don't keep incrementing
        @stdout.puts "Please enter the path for your shopping cart file"
        input = nil
        while input != "quit"
            input = gets.strip
            #Check if file path exists
            check_filepath(input)
        end
        exit_program
    end

    def check_filepath(input)
        path = input
        if File.exist?(path)
            @stdout.puts ""
            @stdout.puts "File Found"
            @stdout.puts ""
            @shopping_basket = ShoppingBasket.new(path)
            confirm_order
        elsif input != 'quit'
            @stdout.puts "Oops! We couldn't find this file. Please try again."
            user_input
        end
    end

    def confirm_order
        @stdout.puts @shopping_basket.read_data
        confirmation = nil
        @stdout.puts "Confirm order? Y/N"
        confirmation = gets.strip
        if confirmation === "y" || confirmation === "Y"
            @stdout.puts "Loading receipt"
            @stdout.puts "............"
            @stdout.puts ""
            read_line_items
            generate_receipt
        elsif confirmation === "n" || confirmation === "N"
            @stdout.puts "Ok, lets try again. Please enter the path for your shopping cart file"
            user_input
        else 
            @stdout.puts "Invalid input"
        end
    end

    def read_line_items
        parsed_data = @shopping_basket.parsed_data
        # Create a new line item instance for each line item
        parsed_data.each do |line_item|
            quantity = line_item[0]
            product = line_item[1]
            price = line_item[2]
            item = LineItem.new(quantity, product, price)
            @output << [item.quantity, item.product, "#{"%.2f" % item.price_inc_tax}"]
        end
        add_items_to_output
    end
    
    def add_items_to_output
        sum = LineItem.sum_all
        sales_tax = LineItem.sales_tax
        # Line break
        @output << ["\n"]
        @output << ["Sales Taxes: #{"%.2f" % sales_tax}"]
        @output << ["Total: #{"%.2f" % sum}"]
    end

    def generate_receipt
        receipt = Receipt.new(@output)
        receipt.csv_export
        receipt.output_display

        reset_line_items
    end

    def reset_line_items
       LineItem.destroy_all
       @stdout.puts LineItem.all
    end
    def exit_program
        exit
    end
end