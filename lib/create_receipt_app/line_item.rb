class LineItem
    attr_reader :quantity, :product, :price, :price_inc_tax, :is_imported, :is_tax_exempt
    attr_accessor :all, :sum, :sales_tax
     
    @@all = []
    @@sales_tax = 0
    @@sum = 0

    def initialize quantity = 1, product, price
        @@all << self
        @quantity = quantity.to_i
        @product = product
        @price = price.to_f
        @is_tax_exempt = self.is_tax_exempt?
        @is_imported = self.is_imported?
        @tax_amount = self.calculate_tax
        @price_inc_tax = @price + @tax_amount
    end

    def calculate_tax
        basic_tax = Tax.new(self).basic_tax
        import_tax = Tax.new(self).import_tax
        tax_amount = Tax.new(self).total
        
        # Add recently calculated tax to total
        @@sales_tax += tax_amount.round(2)
        @@sum += (tax_amount + @price).round(2)
        tax_amount
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

    #reset everything
    def self.destroy_all
        all.clear
        @@sum = 0
        @@sales_tax = 0
    end
end