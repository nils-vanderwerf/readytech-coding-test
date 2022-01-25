class ShoppingBasket
    attr_reader :order

    def initialize(order)
        # Method CSV.parse returns the entire CSV data:
        @order = CSV.read(order)
    end

    def read_data
        @order
    end
end