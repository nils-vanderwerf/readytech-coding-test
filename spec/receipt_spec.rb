require 'receipt'

RSpec.describe Receipt do
    receipt = Receipt.new("Nils")
    context "greeting method is called with a name" do 
        it "greets someone with 'Hello there!' and their name" do
            expect(receipt.greeting).to eq("Hello there, #{receipt.name}!")
        end
    end

    context "goodbye method is called with a name" do 
        it "Says 'Goodbye!' to someone with their name" do
            expect(receipt.salutation).to eq("Goodbye, #{receipt.name}!")
        end
    end
end

# describe 'CSV generator' do 
#     it 'Creates a CSV file with line items from the receipt' do 
#         headers = %w{Quantity Product Price}
#         input1 = [
#             [1, 'book', 12.49],
#             [1, 'music cd', 14.99],
#             [1, 'chocolate bar', 0.85]
#         ]
#         input2 = [
#             [1, 'imported box of chocolates', 10.00],
#             [1, 'imported bottle of perfume', 47.50]
#         ]
#         input3 = [ 
#             [1, 'imported bottle of perfume', 27.99],
#             [1, 'bottle of perfume', 18.99],
#             [1, 'packet of headache pills', 9.75],
#             [1, 'box of imported chocolates', 11.25]
#         ]
    
#     test_csv_file = File.read('output/test_receipt.csv').gsub(/\r\n?/, '\n')
#     csv_tool headers, input1
#     generated_file = File.read('output/generated_receipt.csv')
#     expect(generated_file).to eq(test_csv_file)
#     end
# end