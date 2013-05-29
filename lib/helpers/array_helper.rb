module HashToConditions

class ArrayHelper

  #
  # Returns a condition collection (array or hash)
  #
  def to_condition
    raise "bad_key_value_pair" unless @array.length == 2

    parts = @array.first.to_s.split('.')
    raise "field_cannot_be_empty" if parts.empty?

    field = parts[0].strip
    operator = parts[1]
    value = @array.last

    if ['AND', 'OR'].index(field.upcase)
      # handle nested condition
      return {field.upcase => value}
    end

    unless operator
      # handle implicit .eq ({'name' => 'value'}) or .like ({'name' => 'value%'})
      operator = value.to_s.index('%') ? 'like' : 'eq'
    end
    operator = operator.downcase
    mapped = operator.to_operator
    raise "unknown_operator" unless mapped

    # handle .null or .nnull, suppress value
    return  [field + mapped] if operator.index('null')

    # handle .in (?) or .between ? and ?
    if ['in', 'between'].index(operator)
      values = value.to_s.split(',').collect { | ea | ea.strip }
      if 'in' == operator
        result = [field + mapped, values]
      else
        # between
        result = [field + mapped, values[0], values[1]]
      end
      return result
    end

    [field + mapped, value]
  end


  protected

    def initialize(array)
      @array = array
    end
end

end

