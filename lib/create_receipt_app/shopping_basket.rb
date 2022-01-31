class ShoppingBasket
    attr_reader :data

    def initialize(path)
        # reads the file, removing unnecessary charracters
        @data = File.read(path).gsub(/\rn?/, "")
    end

    
    def read_data
        puts @data
        @data
    end

end