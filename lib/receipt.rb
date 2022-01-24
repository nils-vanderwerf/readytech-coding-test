class Receipt
    attr_reader :name
    def initialize(name)
        @name = name
    end

    def greeting
        "Hello there, #{@name}!"
    end

    def salutation
       "Goodbye, #{@name}!"
    end
end

    #     #add write permissions to file (wb)
    # def csv_tool headers, data
    #     CSV.open('output/generated_receipt.csv', 'wb') do | csv |
    #         csv << headers
    #         data.each do |column|
    #             csv << column
    #     end
    # end

    # File needs to be created with the name ad path of:
    # output/receipt_csv



# headers = %w{Quantity Product Price}
# input1 = [
#     [1, 'booktest', 12.49],
#     [1, 'music cd', 14.99],
#     [1, 'chocolate bar', 0.85]
# ]

# csv_tool headers, input1

