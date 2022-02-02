require_relative '../lib/create_receipt_app'
require_relative "../lib/create_receipt_app/line_item"

RSpec.describe CLI do
    let(:stdin) { StringIO.new }
    let(:stdout) { StringIO.new }

    let(:cli) {described_class.new(stdout)}

    subject { cli }

    describe "executing instructions from a file" do
        it 'prints a Welcome message on cli executable' do
            expect {system %(./bin/create_receipt) }.to output(a_string_including('WELCOME'))
            .to_stdout_from_any_process
        end

        describe '#user_input' do
            context 'with valid commands' do
                it 'quits the application when user types quit' do
                    cli.stub(:gets) {"quit"}
                    expect { cli.user_input }.to raise_error SystemExit
                end
            end
        end

        describe '#check_filepath' do
            input1 ='input/order1.csv'
            input2 = 'input/order2.csv'
            input3 = 'input/order3.csv'
            input4 = 'bad_file.csv'
            
            let(:shopping_basket) {ShoppingBasket.new(input1)}
            context 'with invalid commands' do
                it 'successfully reads from input 1' do
                    expect { File.read(input1) }.to_not raise_error(Errno::ENOENT)
                end
                it 'successfully reads from input 2' do
                    expect { File.read(input2) }.to_not raise_error(Errno::ENOENT)
                end
                it 'successfully reads from input 3' do
                    expect { File.read(input3) }.to_not raise_error(Errno::ENOENT)
                end
            end

            context 'with invalid commands' do
                it 'fails with bad file' do
                    expect { File.read(input4) }.to raise_error(Errno::ENOENT)
                    cli.stub(:gets) {input4}
                    expect{cli.check_filepath(input4)}.to output(a_string_including("Oops! We couldn't find this file. Please try again.")).to_stdout_from_any_process
            end
        end
    end
end

    # describe '#check_filepath' do
    #     it "checks filepath and makes new shopping basket instance" do
    #         
    #         expect {cli.check_filepath("input/order1.csv") }.to 
    #     end
    # end
end

# # TODO
# # - calculate tax test 1 for each case (e.g. imported / not imported etc.)
# # - test a function that loads a file and does your logic and writes to another file and in the test, read from
# #   the output file and check it has the correct contents
# # - maybe a test for parsing user input and checking file exists                