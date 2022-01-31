require_relative '../lib/create_receipt_app'

RSpec.describe LineItem do
    basket1 = ShoppingBasket.new('input/order1.csv').parsed_data
    basket2 = ShoppingBasket.new('input/order2.csv').parsed_data
    basket3 = ShoppingBasket.new('input/order3.csv').parsed_data

    basket1.each do |line_item|
        quantity = line_item[0].to_i
        product = line_item[1]
        price = line_item[2].to_f
        item = LineItem.new(quantity, product, price)

        it  "adds new line items  based on data from the first input file" do
            expect(item).to have_attributes(:quantity => line_item[0].to_i, :product => line_item[1], :price => line_item[2].to_f)
        end
    end

    basket2.each do |line_item|
        quantity = line_item[0].to_i
        product = line_item[1]
        price = line_item[2].to_f
        item = LineItem.new(quantity, product, price)

        it  "adds new line items  based on data from the second input file" do
            expect(item).to have_attributes(:quantity => line_item[0].to_i, :product => line_item[1], :price => line_item[2].to_f)
        end
    end

    basket3.each do |line_item|
        quantity = line_item[0].to_i
        product = line_item[1]
        price = line_item[2].to_f
        item = LineItem.new(quantity, product, price)

        it  "adds new line items  based on data from the third input file" do
            expect(item).to have_attributes(:quantity => line_item[0].to_i, :product => line_item[1], :price => line_item[2].to_f)
        end
    end

     LineItem.all.each do |line|
        puts line.product
     end
end

# TODO
# - calculate tax test 1 for each case (e.g. imported / not imported etc.)
# - test a function that loads a file and does your logic and writes to another file and in the test, read from
#   the output file and check it has the correct contents
# - maybe a test for parsing user input and checking file exists  

# def read_line_items
#     parsed_data = @shopping_basket.parsed_data
#     # Create a new line item instance for each line item
#     parsed_data.each do |line_item|
#         quantity = line_item[0].to_i
#         product = line_item[1]
#         price = line_item[2].to_f
#         item = LineItem.new(quantity, product, price)
#         @output << [item.quantity, item.product, item.price_inc_tax]
#     end
#     add_items_to_output
# end              