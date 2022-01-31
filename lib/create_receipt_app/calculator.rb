class Calculator

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
        @total_tax = self.total_tax
    end

    def basic_tax
        @tax_exempt ? 0 : ((@basic_tax_rate * @price) * @qty / @round_off).ceil.to_f / 20
      end
      def import_tax
        @imported ? ((@import_rate * @price) * @qty / @round_off).ceil.to_f / 20 : 0
      end

      def total_tax
        self.basic_tax + self.import_tax
      end
end