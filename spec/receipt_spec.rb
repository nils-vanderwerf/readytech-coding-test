require_relative '../lib/receipt'

RSpec.describe Receipt  do
#  A row separator delimits table rows. A common row separator is the newline character "\n".
#  A column separator delimits fields in a row. A common column separator is the comma character ","
#  Source https://ruby-doc.org/stdlib-3.0.0/libdoc/csv/rdoc/CSV.html
    
    it 'prints the receipt details for a shopping basket' do
        input1 = "Quantity, Product, Price\n1, book, 12.49\n1, music cd, 14.99\n1, chocolate bar, 0.85"
        input2 = [
            ["Quantity", "Product", "Price"],
            ["1", 'imported box of chocolates', "10.00"],
            ["1", 'imported bottle of perfume', "47.50"]
        ]

        input3 = [
            ["Quantity", "Product", "Price"], 
            ["1", 'imported bottle of perfume', "27.99"],
            ["1", 'bottle of perfume', "18.99"],
            ["1", 'packet of headache pills', "9.75"],
            ["1", 'box of imported chocolates', "11.25"]
        ]


        receipt1 = Receipt.new(input1)
        receipt2 = Receipt.new(input2)
        receipt3 = Receipt.new(input3)
        expect (receipt1.csv_export).to eq("boss")
        expect (receipt2.csv_export).to eq("boss")
        expect (receipt2.csv_export).to eq("boss")
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