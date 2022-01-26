require 'csv'

class Receipt
    attr_reader :order

    def initialize(order)
        # Method CSV.parse returns the entire CSV data, drops header
        @order = order
    end

    def csv_export
        CSV.open(""'output/generated_receipt.csv', 'wb') do |csv|
            @order.each do |column|
                csv << column
            end
        end
    end

    def output_display
        @order.each do |row|
            puts row
        end
    end    
end