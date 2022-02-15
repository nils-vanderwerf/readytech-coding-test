class CLI
    attr_accessor :shopping_basket, :output

    def initialize(stdout=STDOUT)
        @shopping_basket = []
        @output = []
        @stdout = stdout
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
         #reset line items class values to 0, so they don't keep incrementing
        puts "Please enter the path for your shopping cart file"
        input = nil
        while input != "quit"
            input = gets.strip
            #Check if file path exists
            valid_file = check_filepath(input)
            if valid_file
                prints_file_found
                create_shopping_basket(input)
                confirm_order
            else 
                retry_input
            end
        end
        exit_program
    end

    def check_filepath(input)
        if File.exist?(input)
            return true
        else
            return false
        end
    end

    def create_shopping_basket(path)
        @shopping_basket = ShoppingBasket.new(path)
    end

    def prints_file_found
        puts ""
        puts "File Found"
        puts ""
    end

    def confirm_order
        puts @shopping_basket.read_data
        confirmation = nil
        puts "Confirm order? Y/N"
        confirmation = gets.strip
        if confirmation === "y" || confirmation === "Y"
            puts "Loading receipt"
            puts "............"
            puts ""
            read_line_items
            generate_receipt
        elsif confirmation === "n" || confirmation === "N"
            puts "Ok, lets try again. Please enter the path for your shopping cart file"
            user_input
        else 
            puts "Invalid input"
        end
    end

    def retry_input
        puts "Oops! We couldn't find this file. Please try again."
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