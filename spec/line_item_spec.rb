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
    context 'determines import and tax exemption' do
        book = LineItem.all.find{|x| x.product === 'book'}
        headache = LineItem.all.find{|x| x.product === 'packet of headache pills'}
        chocolate = LineItem.all.find{|x| x.product === 'chocolate bar'}
        imported_chocolates = LineItem.all.find{|x| x.product === 'imported box of chocolates'}
        box_imported_chocolates = LineItem.all.find{|x| x.product === 'box of imported chocolates'}
        perfume = LineItem.all.find{|x| x.product === 'bottle of perfume'}
        first_imported_perfume = LineItem.all.find{|x| x.price === 47.50}
        second_imported_perfume = LineItem.all.find{|x| x.price === 27.99}

        it 'evaluates a book to be tax exempt' do
            expect(book.is_tax_exempt?).to be true
        end
        it 'evaluates a packet of headache pills to be a medical product which is tax exempt' do
            expect(headache.is_tax_exempt?).to be true
        end
        it 'evaluates chocolate bar to be food which is tax exempt' do
            expect(chocolate.is_tax_exempt?).to be true
        end
        it 'evaluates chocolate bar to be food which is tax exempt' do
            expect(perfume.is_tax_exempt?).to be false
        end
        it 'evaluates a imported box of chocolates to be imported' do
            expect(imported_chocolates.is_imported?).to be true
        end
        it 'evaluates a imported box of chocolates to be imported' do
            expect(box_imported_chocolates.is_imported?).to be true
        end
        it 'evaluates a imported bottle of perfume to be imported' do
            expect(first_imported_perfume.is_imported?).to be true
        end
        it 'evaluates a imported bottle of perfume to be imported' do
            expect(second_imported_perfume.is_imported?).to be true
        end
        it 'correctly calculates price including tax for books' do
            expect(book.price_inc_tax).to eq(12.49)
        end
        it 'correctly calculates price including tax for a packet of headache pills' do
            expect(headache.price_inc_tax).to eq(9.75)
        end
        it 'correctly calculates price including tax for a chocolate bar' do
            expect(chocolate.price_inc_tax).to eq(0.85)
        end
        it 'correctly calculates price including tax for imported chocolates' do
            expect(imported_chocolates.price_inc_tax).to eq(10.50)
        end
        it 'correctly calculates price including tax for a box of imported chocolates (note sentence wording)' do
            expect(box_imported_chocolates.price_inc_tax).to eq(11.8)
            ## note that brief says 11.85, but on my calculations the tax rate is 5%, and 11.25 x 1.05 is 11.8
        end
        it "correctly calculates price including tax for an imported bottle of perfume" do
            expect(first_imported_perfume.price_inc_tax).to eq(54.65)
        end
        it "correctly calculates price including tax for an imported bottle of perfume" do
            expect(second_imported_perfume.price_inc_tax).to eq(32.19)
        end
    context 'correctly calculates total sales tax' do
        it 'calculates total and sales tax on an order' do
            #destroy all instances from other tests, to not interfere with totals
            LineItem.destroy_all
            line_item_1 =  LineItem.new(1,"book", 12.49)
            line_item_2 =  LineItem.new(1,"music CD", 14.99)
            line_item_3 =  LineItem.new(1,"chocolate bar", 0.85)

            expect(LineItem.sales_tax).to eq(1.5)
            expect(LineItem.sum_all).to eq(29.83)
        end
    end
end

# TODO
# - calculate tax test 1 for each case (e.g. imported / not imported etc.)
# - test a function that loads a file and does your logic and writes to another file and in the test, read from
#   the output file and check it has the correct contents
# - maybe a test for parsing user input and checking file exists 