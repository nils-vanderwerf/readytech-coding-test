class Tax
    attr_reader :line_item

    def initialize(line_item)
        @line_item = line_item
        @price = line_item.price
        @quantity = line_item.quantity
        @imported = line_item.is_imported
        @tax_exempt = line_item.is_tax_exempt
        @basic_tax_rate = 0.10
        @import_rate = 0.05
        @round_off = 0.05
    end

    def basic_tax
        @tax_exempt ? 0 : ((@basic_tax_rate * @price) * @quantity / @round_off ).ceil.to_f * @round_off
    end
    
    def import_tax
      @imported ? ((@import_rate * @price) * @quantity / @round_off).ceil.to_f * @round_off : 0
    end 
end