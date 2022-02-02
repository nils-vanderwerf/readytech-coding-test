require 'csv'

class Receipt
    attr_accessor :items
    attr_reader :order

    def initialize(order, stdout=STDOUT)
        # Method CSV.parse returns the entire CSV data, drops header
        @order = order
        items = []
        @stdout = stdout
    end

    def csv_export
        CSV.open(""'output/generated_receipt.csv', 'wb') do |csv|
            @order.each do |column|
                csv << column
            end
        end
    end

    def total_price
        return 0 if items.empty?
        items.map(&:total_price).inject  :+
      end
  
      def total_tax
        return 0 if items.empty?
        items.map(&:purchase_tax).inject :+
      end

    def output_display
        @order.each do |row|
            if row.include?("Sales Tax") || row.include?("Total")
                @stdout.puts row.join(": ")
            else 
                @stdout.puts row.join(", ")
            end
        end
    end    
end