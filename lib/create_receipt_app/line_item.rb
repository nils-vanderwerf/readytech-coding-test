require 'rounding'

class LineItem

    attr_reader :quantity, :product, :item_cost

    @@all = []
    @@sales_tax = 0
    @@sum = 0

    @@exempt_items = {
        food: ["chocolate"],
        books: ["book"],
        medical: ["packet of headache pills"]
    }

    def initialize(row)
        @@all << self
        @quantity = row[0].to_i
        @product = row[1]
        @price = row[2].to_d
        
        @tax_amount = self.calculate_tax
        puts "PRODUCT", @product, "TAX AMOUNT", @tax_amount
        @item_cost = (@price + @tax_amount).round(2)
        # add tax amount to toal sales amount for this class
        @@sales_tax += @tax_amount
        # add item cost to sum
        @@sum += (@quantity * @item_cost).round(2)
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
        #p is price, n is tax amount, total is np/100 rounded to the nearest 0.05
        p = @price
        n = 10

        if !self.is_imported? && self.is_food_product? || self.is_book? || self.is_medical_product?
           n = 0
        elsif self.is_imported? && !(self.is_food_product? || self.is_book? || self.is_medical_product?)
            n = 15
        elsif self.is_imported? && self.is_food_product? || self.is_book? || self.is_medical_product?
           n = 5
        else 
            n=10
        end

        @tax_amount = (p * n/100 *20).ceil.to_d/20.0
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

    def delete_instance
        self.delete_all
    end
end