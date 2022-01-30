class CLI

    attr_accessor :shopping_basket, :parsed_data, :output

    def initialize
        @shopping_basket = []
        @parsed_data = []
        @output = []
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
         if !LineItem.all.empty?
            LineItem.all.map do |instance| 
                LineItem.find_by(product: instance.product).destroy 
            end
            puts LineItem.all
         end
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
            user_input
        end
    end

    def confirm_order
        puts @shopping_basket
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

    def read_line_items
        @parsed_data = CSV.parse(@shopping_basket, :headers => true)
        # Create a new line item instance for each line item
        @parsed_data.each do |line_item|
            item = LineItem.new(line_item)
            @output << [item.quantity, item.product, item.price_inc_tax]
        end
        add_items_to_output
    end
    
    def add_items_to_output
        sum = LineItem.sum_all
        sales_tax = LineItem.sales_tax
        # Line break
        @output << ["\n"]
        @output << ["Sales Tax", sales_tax]
        @output << ["Total", sum]
    end

    def generate_receipt
        receipt = Receipt.new(@output)
        receipt.csv_export
        receipt.output_display
    end

end