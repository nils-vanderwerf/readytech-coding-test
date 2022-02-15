require_relative '../lib/create_receipt_app'
require_relative "../lib/create_receipt_app/line_item"
require 'stringio'

RSpec.describe CLI do
    let(:stdout) { StringIO.new }
    let(:cli) {CLI.new(stdout)}

    context "executing instructions from a file" do
        it 'prints a Welcome message on cli executable' do
            expect {system %(./bin/create_receipt) }.to output(a_string_including('WELCOME'))
            .to_stdout_from_any_process
        end

        describe '#user_input' do
            it 'quits the application when user types quit' do
                    cli.stub(:gets) {'quit'}
                    expect { cli.user_input }.to raise_error SystemExit
                end
        end

        describe '#check_filepath' do
            let (:inputs) {['input/order1.csv', 'input/order2.csv', 'input/order3.csv' ]}
            let (:bad_input) { 'bad_input.csv'}
            let (:baskets) {[]}
            
            it 'takes in filepath and checks the file' do
                inputs.each do | path |
                    baskets << ShoppingBasket.new(path)
                    cli.stub(:gets) {path}
                    expect(cli.check_filepath(path)).to be true
                end
            end
            it 'check filepath is false if bad file' do
                expect(cli.check_filepath(bad_input)).to be false
            end
        end
        
    end
end

# # TODO
# # - calculate tax test 1 for each case (e.g. imported / not imported etc.)
# # - test a function that loads a file and does your logic and writes to another file and in the test, read from
# #   the output file and check it has the correct contents
# # - maybe a test for parsing user input and checking file exists                