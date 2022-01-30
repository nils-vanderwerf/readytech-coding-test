require './lib/create_receipt_app'

RSpec.describe CLI do
    it "prints a welcome message" do
        expect { system %(./bin/create_app_receipt) }
            .to output(a_string_including("WELCOME"))
            .to_stdout_from_any_process
    end
end