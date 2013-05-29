module HashToConditions

class HashHelper

  #
  # Returns a complete condition array
  #
  def to_conditions
    raise "empty_condition" if @hash.empty?
    result_s = ''
    result_a = []
    join_s = @hash.first.first
    if ['AND', 'OR'].index(join_s.upcase)
      parse(@hash.first.last, join_s.upcase, result_s, result_a)
    else
      parse(@hash, 'AND', result_s, result_a)
    end
    result_a.unshift(result_s)
    result_a
  end


  protected

    def parse(hash, join_s, result_s, result_a, nest_lev=0)
      raise "nested_too_deep_or_cyclic" unless nest_lev < 32

      result_s << '('
      count = hash.length
      hash.each_pair { | pair |
        arr = pair.to_condition
        if arr.kind_of?(Hash)
          # handle nested condition
          parse(arr.first.last, arr.first.first, result_s, result_a, 1+nest_lev)
        else
          result_s << arr.shift
          result_a.concat(arr)
        end
        count -= 1
        if count > 0
          result_s << ' '
          result_s << join_s
          result_s << ' '
        end
      }
      result_s << ')'
    end

    def initialize(hash)
      @hash = hash
    end
end

end

