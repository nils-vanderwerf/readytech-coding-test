class BigDecimal

    # The ceil() is an inbuilt method in Ruby returns the smallest number which is greater than or equal to the given number by keeping a precision of n digits of the decimal part. 
    #https://www.geeksforgeeks.org/ruby-numeric-ceil-function/
    def round_up_05
      (self*20).ceil.to_d/20.0
    end
  end
  