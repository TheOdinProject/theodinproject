class Test
    def initialize(number)
        @number
    end

    def hello
        puts "Hello World!"
    end

    def sum(*args)
        result = 0
        args.each do |number|
            result += number
        end
    end
end