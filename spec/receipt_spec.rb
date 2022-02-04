RSpec.describe Receipt do
    context 'CSV generator' do
        it 'successfully exports the first input file' do
            test_receipt_1 = File.read('output/test_receipt1.csv').gsub(/\r\n?/, "\n")
            content1 = "Quantity,Product,Price\n1,book,12.49\n1,music cd,14.99\n1,chocolate bar,0.85"
            
            basket1 = double('input/order1.csv', :read_data => content1, :parsed_data => CSV.parse(content1, :headers => true) )

            basket_1_parsed_data = basket1.parsed_data

            puts basket_1_parsed_data

            # Create a new line item instance for each line item
            basket_1_parsed_data.each do |line_item|
                quantity = line_item[0]
                product = line_item[1]
                price = line_item[2]
                item = LineItem.new(quantity, product, price)
                output << [item.quantity, item.product, "#{"%.2f" % item.price_inc_tax}"]
            end

            receipt = Receipt.new(output)
            receipt.csv_export

            generated_file = File.read('output/generated_receipt.csv')

            expect(generated_file).to eq(test_receipt_1)
        end

        it 'successfully exports the second input file' do
            output = []
            test_receipt_2 = File.read('output/test_receipt2.csv').gsub(/\r\n?/, "\n")
            content2 = "Quantity,Product,Price\n1,imported box of chocolates,10\n1,imported bottle of perfume,47.5"
            
            basket2 = double('input/order2.csv', :read_data => content2, :parsed_data => CSV.parse(content2, :headers => true) )
            basket_2_parsed_data = basket2.parsed_data
            
            # Create a new line item instance for each line item
            basket_2_parsed_data.each do |line_item|
                quantity = line_item[0]
                product = line_item[1]
                price = line_item[2]
                item = LineItem.new(quantity, product, price)
                output << [item.quantity, item.product, "#{"%.2f" % item.price_inc_tax}"]
            end

            receipt = Receipt.new(output)
            receipt.csv_export

            generated_file = File.read('output/generated_receipt.csv')

            expect(generated_file).to eq(test_receipt_2)
        end
        it 'successfully exports the third input file' do
            output = []
            test_receipt_3 = File.read('output/test_receipt3.csv').gsub(/\r\n?/, "\n")
            content3 = "Quantity,Product,Price\n1,imported bottle of perfume,27.99\n1,bottle of perfume,18.99\n1,packet of headache pills,9.75\n1,box of imported chocolates,11.25"
            
            basket3 = double('input/order3.csv', :read_data => content3, :parsed_data => CSV.parse(content3, :headers => true) )
            basket_3_parsed_data = basket3.parsed_data
              # Create a new line item instance for each line item
            basket_3_parsed_data.each do |line_item|
                quantity = line_item[0]
                product = line_item[1]
                price = line_item[2]
                item = LineItem.new(quantity, product, price)
                output << [item.quantity, item.product, "#{"%.2f" % item.price_inc_tax}"]
            end
        
            receipt = Receipt.new(output)
            receipt.csv_export

            generated_file = File.read('output/generated_receipt.csv')

            expect(generated_file).to eq(test_receipt_3)
        end
    end
    context 'Print to standard output' do
    end
end