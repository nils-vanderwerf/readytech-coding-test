require 'csv'

class Receipt
    attr_reader :order
    def initialize(order)
        # Method CSV.parse returns the entire CSV data:
        @order = CSV.parse(order, headers: true)
    end

    def csv_export
        puts @order
        CSV.open('output/generated_receipt.csv', 'wb') do |csv|
            @order.each do |column|
                csv << column
            end
        end
    end
end