require_relative '../lib/create_receipt_app'

RSpec.describe CLI do
    it "prints a welcome message" do
        expect { }
    end
end

# TODO
# - calculate tax test 1 for each case (e.g. imported / not imported etc.)
# - test a function that loads a file and does your logic and writes to another file and in the test, read from
#   the output file and check it has the correct contents
# - maybe a test for parsing user input and checking file exists                