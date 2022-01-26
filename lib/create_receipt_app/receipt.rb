require 'csv'

class Receipt
    attr_reader :order

    def initialize(order)
        # Method CSV.parse returns the entire CSV data, drops header
        @order = order.drop(1)
    end

    def csv_export
        CSV.open(""'output/generated_receipt.csv', 'wb') do |csv|
            @order.each do |column|
                csv << column
            end
        end
    end

    
end