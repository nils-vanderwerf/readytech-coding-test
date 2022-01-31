require_relative '../lib/create_receipt_app'

RSpec.describe ShoppingBasket do
    basket1 = ShoppingBasket.new('input/order1.csv')
    basket2 = ShoppingBasket.new('input/order2.csv')
    basket3 = ShoppingBasket.new('input/order3.csv')

    it "takes file path as user input and reads file" do
        expect(basket1.read_data).to eq("Quantity,Product,Price\n1,book,12.49\n1,music cd,14.99\n1,chocolate bar,0.85")
        expect(basket2.read_data).to eq("Quantity,Product,Price\n1,imported box of chocolates,10\n1,imported bottle of perfume,47.5") 
        expect(basket3.read_data).to eq("Quantity,Product,Price\n1,imported bottle of perfume,27.99\n1,bottle of perfume,18.99\n1,packet of headache pills,9.75\n1,box of imported chocolates,11.25")
    end  
    it 'parses data to CSV format correctly' do
        basket1_parsed = basket1.parsed_data
        basket2_parsed = basket2.parsed_data
        basket2_parsed = basket3.parsed_data

        headers = ["Quantity", "Product", "Price"]

        basket1_expected = [
            ["1", "book", "12.49"],
            ["1", "music cd", "14.99"],
            ["1", "chocolate bar", "0.85"]
        ]
        basket2_expected = [
            ["1", "imported box of chocolates", "10.00"],
            ["1", "imported bottle of perfume", "47.50"]
        ]
        basket3_expected = [
            ["1", "imported bottle of perfume", "27.99"],
            ["1", "bottle of perfume", "18.99"],
            ["1", "packet of headache pills", "9.75"],
            ["1", "box of imported chocolates", "11.25"]
        ]
        # BASKET 1

        expect(basket1.parsed_data[0]["Quantity"]).to eq("1")
        expect(basket1.parsed_data[0]["Product"]).to eq("book")
        expect(basket1.parsed_data[0]["Price"]).to eq("12.49")

        expect(basket1.parsed_data[1]["Quantity"]).to eq("1")
        expect(basket1.parsed_data[1]["Product"]).to eq("music cd")
        expect(basket1.parsed_data[1]["Price"]).to eq("14.99")

        expect(basket1.parsed_data[2]["Quantity"]).to eq("1")
        expect(basket1.parsed_data[2]["Product"]).to eq("chocolate bar")
        expect(basket1.parsed_data[2]["Price"]).to eq("0.85")

        # BASKET 2
        expect(basket2.parsed_data[0]["Quantity"]).to eq("1")
        expect(basket2.parsed_data[0]["Product"]).to eq("imported box of chocolates")
        expect(basket2.parsed_data[0]["Price"]).to eq("10")

        expect(basket2.parsed_data[1]["Quantity"]).to eq("1")
        expect(basket2.parsed_data[1]["Product"]).to eq("imported bottle of perfume")
        expect(basket2.parsed_data[1]["Price"]).to eq("47.5")

        # BASKET 3
        expect(basket3.parsed_data[0]["Quantity"]).to eq("1")
        expect(basket3.parsed_data[0]["Product"]).to eq("imported bottle of perfume")
        expect(basket3.parsed_data[0]["Price"]).to eq("27.99")

        expect(basket3.parsed_data[1]["Quantity"]).to eq("1")
        expect(basket3.parsed_data[1]["Product"]).to eq("bottle of perfume")
        expect(basket3.parsed_data[1]["Price"]).to eq("18.99")

        expect(basket3.parsed_data[2]["Quantity"]).to eq("1")
        expect(basket3.parsed_data[2]["Product"]).to eq("packet of headache pills")
        expect(basket3.parsed_data[2]["Price"]).to eq("9.75")

        expect(basket3.parsed_data[3]["Quantity"]).to eq("1")
        expect(basket3.parsed_data[3]["Product"]).to eq("box of imported chocolates")
        expect(basket3.parsed_data[3]["Price"]).to eq("11.25")


    end
end

# TODO
# - calculate tax test 1 for each case (e.g. imported / not imported etc.)
# - test a function that loads a file and does your logic and writes to another file and in the test, read from
#   the output file and check it has the correct contents
# - maybe a test for parsing user input and checking file exists                