require 'rspec'
require 'csv'

# File needs to be created with the name ad path of:
# output/receipt_csv

#add write permissions to file (wb)
def csv_tool headers, data
        CSV.open('output/generated_receipt.csv', 'wb') do | csv |
            csv << headers
            data.each do |column|
                csv << column
        end
    end
end

headers = %w{Quantity Product Price}
input1 = [
    [1, 'booktest', 12.49],
    [1, 'music cd', 14.99],
    [1, 'chocolate bar', 0.85]
]

csv_tool headers, input1

describe 'CSV generator' do 
    it 'Creates a CSV file with line items from the receipt' do 
        headers = %w{Quantity Product Price}
        input1 = [
            [1, 'book', 12.49],
            [1, 'music cd', 14.99],
            [1, 'chocolate bar', 0.85]
        ]
        input2 = [
            [1, 'imported box of chocolates', 10.00],
            [1, 'imported bottle of perfume', 47.50]
        ]
        input3 = [
            [1, 'imported bottle of perfume', 27.99],
            [1, 'bottle of perfume', 18.99],
            [1, 'packet of headache pills', 9.75],
            [1, 'box of imported chocolates', 11.25]
        ]
    
    test_csv_file = File.read('output/test_receipt.csv').gsub(/\r\n?/, '\n')
    csv_tool headers, input1
    generated_file = File.read('output/generated_receipt.csv')
    expect(generated_file).to eq(test_csv_file)
    end
end