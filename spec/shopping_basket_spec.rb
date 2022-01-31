require_relative '../lib/create_receipt_app'

RSpec.describe ShoppingBasket do
    it "takes file path as user input and reads file" do
        expect(ShoppingBasket.new('input/order1.csv').read_data).to eq("Quantity,Product,Price\n1,book,12.49\n1,music cd,14.99\n1,chocolate bar,0.85")
        expect(ShoppingBasket.new('input/order2.csv').read_data).to eq("Quantity,Product,Price\n1,imported box of chocolates,10\n1,imported bottle of perfume,47.5") 
        expect(ShoppingBasket.new('input/order3.csv').read_data).to eq("Quantity,Product,Price\n1,imported bottle of perfume,27.99\n1,bottle of perfume,18.99\n1,packet of headache pills,9.75\n1,box of imported chocolates,11.25")
    end
end

# TODO
# - calculate tax test 1 for each case (e.g. imported / not imported etc.)
# - test a function that loads a file and does your logic and writes to another file and in the test, read from
#   the output file and check it has the correct contents
# - maybe a test for parsing user input and checking file exists                