require_relative '../lib/create_receipt_app'

RSpec.describe Receipt do
    output = []
    context 'CSV generator' do
        it 'successfully exports the first input file' do
            test_receipt_1 = File.read('output/test_receipt1.csv').gsub(/\r\n?/, "\n")
            content1 = "Quantity,Product,Price\n1,book,12.49\n1,music cd,14.99\n1,chocolate bar,0.85"
            
            basket1 = double('input/order1.csv', :read_data => content1, :parsed_data => CSV.parse(content1, :headers => true) )

            basket_1_parsed_data = basket1.parsed_data
            #destroy all instances from other tests, to not interfere with totals
            LineItem.destroy_all
            # Create a new line item instance for each line item
            basket_1_parsed_data.each do |line_item|
                quantity = line_item[0]
                product = line_item[1]
                price = line_item[2]
                item = LineItem.new(quantity, product, price)
                output << [item.quantity, item.product, "#{"%.2f" % item.price_inc_tax}"]
            end

            sum = LineItem.sum_all
            sales_tax = LineItem.sales_tax
            output << ["\n"]
            output << ["Sales Taxes: #{"%.2f" % sales_tax}"]
            output << ["Total: #{"%.2f" % sum}"]

            receipt = Receipt.new(output)
            receipt.csv_export

            generated_file = File.read('output/generated_receipt.csv').gsub(/\r\n?/, "\n")

            expect(generated_file).to eq(test_receipt_1)
        end

        it 'successfully exports the second input file' do
            output = []
            test_receipt_2 = File.read('output/test_receipt2.csv').gsub(/\r\n?/, "\n")
            content2 = "Quantity,Product,Price\n1,imported box of chocolates,10\n1,imported bottle of perfume,47.5"
            
            basket2 = double('input/order2.csv', :read_data => content2, :parsed_data => CSV.parse(content2, :headers => true) )
            basket_2_parsed_data = basket2.parsed_data
            
            #destroy all instances from other tests, to not interfere with totals
            LineItem.destroy_all
            # Create a new line item instance for each line item
            basket_2_parsed_data.each do |line_item|
                quantity = line_item[0]
                product = line_item[1]
                price = line_item[2]
                item = LineItem.new(quantity, product, price)
                output << [item.quantity, item.product, "#{"%.2f" % item.price_inc_tax}", ]
                
            end
            sum = LineItem.sum_all
            sales_tax = LineItem.sales_tax
            output << ["\n"]
            output << ["Sales Taxes: #{"%.2f" % sales_tax}"]
            output << ["Total: #{"%.2f" % sum}"]

            receipt = Receipt.new(output)
            receipt.csv_export

            generated_file = File.read('output/generated_receipt.csv').gsub(/\r\n?/, "\n")
            expect(generated_file).to eq(test_receipt_2)
        end
        it 'successfully exports the third input file' do
            output = []
            LineItem.destroy_all
            test_receipt_3 = File.read('output/test_receipt3.csv').gsub(/\r\n?/, "\n")
            content3 = "Quantity,Product,Price\n1,imported bottle of perfume,27.99\n1,bottle of perfume,18.99\n1,packet of headache pills,9.75\n1,box of imported chocolates,11.25"
            
            basket3 = double('input/order3.csv', :read_data => content3, :parsed_data => CSV.parse(content3, :headers => true) )
            basket_3_parsed_data = basket3.parsed_data

            #destroy all instances from other tests, to not interfere with totals
            LineItem.destroy_all
              # Create a new line item instance for each line item
            basket_3_parsed_data.each do |line_item|
                quantity = line_item[0]
                product = line_item[1]
                price = line_item[2]
                item = LineItem.new(quantity, product, price)
                output << [item.quantity, item.product, "#{"%.2f" % item.price_inc_tax}"]
            end
            
            sum = LineItem.sum_all
            sales_tax = LineItem.sales_tax
            output << ["\n"]
            output << ["Sales Taxes: #{"%.2f" % sales_tax}"]
            output << ["Total: #{"%.2f" % sum}"]

            receipt = Receipt.new(output)
            receipt.csv_export

            generated_file = File.read('output/generated_receipt.csv').gsub(/\r\n?/, "\n")
            expect(generated_file).to eq(test_receipt_3)
        end
        
    end
    context 'Print to standard output' do
        output_1 = "1, book, 12.49\n1, music cd, 16.49\n1, chocolate bar, 0.85\n\nSales Taxes: 1.50\nTotal: 29.83\n"
        output_2 = "1, imported box of chocolates, 10.5\n1, imported bottle of perfume, 54.65\n\nSales Taxes: 7.65\nTotal: 65.15\n"
        output_3 = "1, imported bottle of perfume, 32.19\n1, bottle of perfume, 20.89\n1, packet of headache pills, 9.75\n1, imported box of chocolates, 11.85\n\nSales Taxes: 6.70\nTotal: 74.68\n"
        it 'prints first receipt to output' do
            cli = CLI.new
            output = [["1, book, 12.49"], ["1, music cd, 16.49"], ["1, chocolate bar, 0.85"], ["\n"], ["Sales Taxes: 1.50"], ["Total: 29.83"]]
            receipt = Receipt.new(output)
            expect{receipt.output_display}.to output(output_1).to_stdout
        end
        it 'prints second receipt to output' do
            cli = CLI.new
            output = [["1, imported box of chocolates, 10.5"], ["1, imported bottle of perfume, 54.65"], ["\n"], ["Sales Taxes: 7.65"], ["Total: 65.15"]]
            receipt = Receipt.new(output)
            expect{receipt.output_display}.to output(output_2).to_stdout
        end
        it 'prints third receipt to output' do
            cli = CLI.new
            output = [["1, imported bottle of perfume, 32.19"], ["1, bottle of perfume, 20.89"], ["1, packet of headache pills, 9.75"], ["1, imported box of chocolates, 11.85"], ["\n"], ["Sales Taxes: 6.70"], ["Total: 74.68"]]
            receipt = Receipt.new(output)
            expect{receipt.output_display}.to output(output_3).to_stdout
        end
    end
end