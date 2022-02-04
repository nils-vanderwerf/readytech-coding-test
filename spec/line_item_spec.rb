require_relative '../lib/create_receipt_app'

RSpec.describe LineItem do
    basket1 = ShoppingBasket.new('input/order1.csv').parsed_data
    basket2 = ShoppingBasket.new('input/order2.csv').parsed_data
    basket3 = ShoppingBasket.new('input/order3.csv').parsed_data

    context "create new line items"
        basket1.each do |line_item|
            quantity = line_item[0].to_i
            product = line_item[1]
            price = line_item[2].to_f
            item = LineItem.new(quantity, product, price)

            it "adds new line items based on data from the first input file" do
                expect(item).to have_attributes(:quantity => line_item[0].to_i, :product => line_item[1], :price => line_item[2].to_f)
            end
        end

        basket2.each do |line_item|
            quantity = line_item[0].to_i
            product = line_item[1]
            price = line_item[2].to_f
            item = LineItem.new(quantity, product, price)

            it  "adds new line items based on data from the second input file" do
                expect(item).to have_attributes(:quantity => line_item[0].to_i, :product => line_item[1], :price => line_item[2].to_f)
            end
        end

        basket3.each do |line_item|
            quantity = line_item[0].to_i
            product = line_item[1]
            price = line_item[2].to_f
            item = LineItem.new(quantity, product, price)

            it "adds new line items based on data from the third input file" do
                expect(item).to have_attributes(:quantity => line_item[0].to_i, :product => line_item[1], :price => line_item[2].to_f)
            end
        end
    end
    context 'determines whether an item is excempt from tax i.e is a book, food, or medical product' do
        it 'evaluates a book to be tax exempt' do
            book = LineItem.all.find{|x| x.product === 'book'}
            expect(book.is_tax_exempt?).to be true
        end
        it 'evaluates a packet of headache pills to be a medical product which is tax exempt' do
            headache = LineItem.all.find{|x| x.product === 'packet of headache pills'}
            expect(headache.is_tax_exempt?).to be true
        end
        it 'evaluates chocolate bar to be food which is tax exempt' do
            chocolate = LineItem.all.find{|x| x.product === 'chocolate bar'}
            expect(chocolate.is_tax_exempt?).to be true
        end
    end
    context 'determines whether an item is imported' do
        it 'evaluates a imported box of chocolates to be imported' do
            imported_chocolates = LineItem.all.find{|x| x.product === 'imported box of chocolates'}
            expect(imported_chocolates.is_imported?).to be true
        end
        it 'evaluates a imported bottle of perfume to be imported' do
            imported_perfume = LineItem.all.find{|x| x.product === 'imported bottle of perfume'}
            expect(imported_perfume.is_imported?).to be true
        end
    end

# TODO
# - calculate tax test 1 for each case (e.g. imported / not imported etc.)
# - test a function that loads a file and does your logic and writes to another file and in the test, read from
#   the output file and check it has the correct contents
# - maybe a test for parsing user input and checking file exists 