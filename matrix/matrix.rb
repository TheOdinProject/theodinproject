class Matrix
    attr_reader :rows, :columns
    def initialize(matrix_string)
        @string = matrix_string
        @rows = []
        @columns = []
        get_rows
        get_columns
    end    

    def get_rows
        @string.split("\n").each {|row| @rows << row.split(" ").map(&:to_i)}
    end

    def get_columns
        @rows[0].each_index do |col|
            ary = []
            @rows.each{|row| ary << row[col]}
            @columns << ary
        end
    end
end