class CLI
    attr_accessor :shopping_basket, :output

    def initialize(stdout=STDOUT)
        @shopping_basket = []
        @output = []
        @stdout = stdout
    end 

    def call
        reset_line_items
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
         #reset line items class values to 0, so they don't keep incrementing
        puts "Please enter the path for your shopping cart file"
        input = gets.strip
        #Check if file path exists
        valid_file = check_filepath(input)
        if valid_file
            prints_file_found(input)
            confirm_order
        elsif input === "quit"
            exit_program
        else 
            retry_input
            user_input
        end
    end

    def check_filepath(input)
        if File.exist?(input)
            return true
        else
            return false
        end
    end

    def prints_file_found(input)
        puts "\n\n\File Found\n\n"
        @shopping_basket = create_shopping_basket(input)
        puts @shopping_basket.read_data
    end

    def create_shopping_basket(path)
        @shopping_basket = ShoppingBasket.new(path)
    end

    def confirm_order 
        confirmation = nil
        puts "Confirm order? Y/N"
        confirmation = gets.strip
        if confirmation === "y" || confirmation === "Y"
            puts "Loading receipt"
            puts "............"
            puts ""
            read_line_items
            generate_receipt(@output)
        elsif confirmation === "n" || confirmation === "N"
            puts "Ok, lets try again. Please enter the path for your shopping cart file"
            user_input
        elsif confirmation === "quit"
            exit_program
        else 
            retry_input 
        end
        confirm_order
    end

    def retry_input
        @stdout = "Oops! We couldn't find this file. Please try again."
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

    def generate_receipt(output)
        receipt = Receipt.new(output)
        receipt.csv_export
        receipt.output_display
        reset_line_items
        exit_program
    end

    def reset_line_items
       LineItem.destroy_all
       puts LineItem.all
    end
    def exit_program
        exit
    end
end