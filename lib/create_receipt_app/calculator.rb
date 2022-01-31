class Calculator

    attr_reader :line_item

    def initialize(line_item)
        @line_item = line_item
        @price = line_item.price
        @quantity = line_item.quantity
        @imported = line_item.is_imported
        @tax_exempt = line_item.is_tax_exempt
        puts "LINEITEM IS IMPORTED #{line_item.is_imported}"
        puts "LINEITEM IS IS TAX EXEMPT #{line_item.is_tax_exempt}"

    end
end