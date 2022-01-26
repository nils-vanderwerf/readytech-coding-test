class LineItem
    @@all = []

    @@exempt_items = {
        food: ["chocolate"],
        books: ["book"],
        medical: ["packet of headache pills"]
    }

    def initialize(row)
        @@all << self
        @quantity = row[0]
        @product = row[1]
        @price = row[2].to_f
        @tax_amount
        self.calculate_tax
        @total_cost = (@price + @tax_amount).floor(2)
        puts "Total Cost: #{@total_cost}"

    end

    def self.all
        @@all
    end

    def calculate_tax
        #p is price, n is tax amount, total is np/100 rounded to the nearest 0.05
        p = @price
        if !self.is_imported? && self.is_food_product? || self.is_book? || self.is_medical_product?
           n = 0
        elsif self.is_imported? && !(self.is_food_product? || self.is_book? || self.is_medical_product?)
            n = 15
        elsif self.is_imported? && self.is_food_product? || self.is_book? || self.is_medical_product?
           n = 5
        else 
           n=10
        end
        @tax_amount = ((p * n/100) / 0.05 ).floor(2).round * 0.05
        puts @product
        puts "Original price: #{p}"
        puts "Tax percentage: #{n}"
        puts "Tax amount: #{@tax_amount}"
        @tax_amount
    end

    def is_food_product?
       @@exempt_items[:food].any? {|i| @product.include?(i)}
    end

    def is_book?
        @@exempt_items[:books].any? {|i| @product.include?(i)}
    end

    def is_medical_product?
        @@exempt_items[:medical].any? {|i| @product.include?(i)}
    end

    def is_imported?
        @product.include? "imported"
    end
end