require 'csv'

class Receipt
    attr_reader :order
    def initialize(order)
        # Method CSV.parse returns the entire CSV data
        @order = CSV.parse(order)
        puts @order
    end
    def csv_export
        CSV.open(""'output/generated_receipt.csv', 'wb') do |csv|
            @order.each do |column|
                csv << column
            end
        end
    end

    def calculate_sales_tax
        running_sales_tax = []
        @order.each do |product|
            running_sales_cd tax << product.last
            puts running_sales_tax
        end
    end
end