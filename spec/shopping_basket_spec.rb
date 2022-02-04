require_relative '../lib/create_receipt_app'

RSpec.describe ShoppingBasket do
    basket1 = ShoppingBasket.new('input/order1.csv')
    basket2 = ShoppingBasket.new('input/order2.csv')
    basket3 = ShoppingBasket.new('input/order3.csv')

    content1 = "Quantity,Product,Price\n1,book,12.49\n1,music cd,14.99\n1,chocolate bar,0.85"
    content2 = "Quantity,Product,Price\n1,imported box of chocolates,10\n1,imported bottle of perfume,47.5"
    content3 = "Quantity,Product,Price\n1,imported bottle of perfume,27.99\n1,bottle of perfume,18.99\n1,packet of headache pills,9.75\n1,box of imported chocolates,11.25"

    it "takes file path as user input and reads file" do
        expect(basket1.read_data).to eq(content1)
        expect(basket2.read_data).to eq(content2) 
        expect(basket3.read_data).to eq(content3)
    end  
    it 'parses data to CSV format correctly' do
        basket1_parsed = basket1.parsed_data

        expect(basket1_parsed[0]["Quantity"]).to eq("1")
        expect(basket1_parsed[0]["Product"]).to eq("book")
        expect(basket1_parsed[0]["Price"]).to eq("12.49")

        expect(basket1_parsed[1]["Quantity"]).to eq("1")
        expect(basket1_parsed[1]["Product"]).to eq("music cd")
        expect(basket1_parsed[1]["Price"]).to eq("14.99")

        expect(basket1_parsed[2]["Quantity"]).to eq("1")
        expect(basket1_parsed[2]["Product"]).to eq("chocolate bar")
        expect(basket1_parsed[2]["Price"]).to eq("0.85")
    end
end

# TODO
# - calculate tax test 1 for each case (e.g. imported / not imported etc.)
# - test a function that loads a file and does your logic and writes to another file and in the test, read from
#   the output file and check it has the correct contents
# - maybe a test for parsing user input and checking file exists                