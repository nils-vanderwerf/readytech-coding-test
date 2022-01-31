class LineItem
    attr_reader :quantity, :product, :price, :price_inc_tax, :is_imported, :is_tax_exempt
     

    @@all = []
    @@sales_tax = 0
    @@sum = 0

    def initialize quantity = nil, product, price
        @@all << self
        @quantity = quantity
        @product = product
        @price = price
        @is_tax_exempt = self.is_tax_exempt?
        @is_imported = self.is_imported?
        @tax_amount = self.calculate_tax
        @price_inc_tax = @price + @tax_amount
        # add tax amount to toal sales amount for this class
        @@sales_tax += @tax_amount
        # add item cost to sum 
        @@sum += @quantity * @price_inc_tax
    end

    def self.all
        @@all
    end

    def self.sales_tax
        @@sales_tax
    end

    def self.sum_all
        @@sum
    end 

    def calculate_tax
        puts self.product
        calculator = Calculator.new(self)
        puts self.price
        puts calculator.total_tax
        calculator.total_tax
    end

    def is_food_product?
        exempt_items[:food].any? {|i| @product.include?(i)}
    end
 
    def is_book?
       exempt_items[:books].any? {|i| @product.include?(i)}
    end
 
    def is_medical_product?
        exempt_items[:medical].any? {|i| @product.include?(i)}
    end

    def is_tax_exempt?
        self.is_food_product? || self.is_book? || self.is_medical_product?
    end
 
    def is_imported?
        @product.include? "imported"
    end

    def exempt_items
       {
            food: ["chocolate"],
            books: ["book"],
            medical: ["packet of headache pills"]
        }
    end
end