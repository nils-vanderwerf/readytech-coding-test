require 'csv'

class Receipt
    attr_reader :order

    @@exempt_items = {
            food: ["chocolate bar", "chocolates" ],
            books: ["book"],
            medical: ["packet of headache pills"]
    }

    def initialize(order)
        # Method CSV.parse returns the entire CSV data, drops header
        @order = order.drop(1)
        calculate_sales_tax
    end

    def calculate_sales_tax
        running_total_tax = []
        @order.each do |item|
            calculate_tax_on_item(item)
            running_total_tax << item
        end
    end

    def calculate_tax_on_item(item)
        check_item = item[1]
    end

    def is_food_product(item)
        exempt_items[:food].any? {|i| check_item.include?(i)}
    end

    # is_book(item)

    #     is_book = exempt_items[:books].any? {|i| check_item.include?(i)}
    #     is_medical_product = exempt_items[:medical].any? {|i| check_item.include?(i)}
    #     is_imported = check_item.include? "imported"

    def csv_export
        CSV.open(""'output/generated_receipt.csv', 'wb') do |csv|
            @order.each do |column|
                csv << column
            end
        end
    end

    
end