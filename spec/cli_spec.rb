require_relative '../lib/create_receipt_app'
require_relative "../lib/create_receipt_app/line_item"

RSpec.describe CLI do
    it 'prints a Welcome message on cli executable' do
        expect {system %(./bin/create_receipt) }.to output(a_string_including('WELCOME'))
        .to_stdout_from_any_process
    end
    it 'asks for user input' do
        expect {CLI.new.user_input }.to output(a_string_including('Please enter the path for your shopping cart file'))
        .to_stdout_from_any_process
    end
end

# # TODO
# # - calculate tax test 1 for each case (e.g. imported / not imported etc.)
# # - test a function that loads a file and does your logic and writes to another file and in the test, read from
# #   the output file and check it has the correct contents
# # - maybe a test for parsing user input and checking file exists                