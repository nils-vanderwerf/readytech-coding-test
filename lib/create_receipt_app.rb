$: << File.dirname(__FILE__)

require 'bigdecimal'
require 'bigdecimal/util'

require "pry"

require 'csv'

require_relative "create_receipt_app/cli"
require_relative "create_receipt_app/shopping_basket"
require_relative "create_receipt_app/line_item"
require_relative "create_receipt_app/receipt"
