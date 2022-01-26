class LineItem
    @@all = []

    def initialize(row)
        @@all << self
        @quantity = row[0]
        @product = row[1]
        @price = row[2]
        puts "QUANTITY #{@quantity}"
        puts "PRODUCT #{@product}"
        puts "PRICE #{@price.to_f}" 
    end

    def self.all
        @@all
    end
end