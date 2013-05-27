module HashToConditions

class ArrayHelper

  #
  # Returns a condition array
  #
  def to_condition
    raise "Invalid key-value pair" unless @array.length == 2
    raise "Bad condition field name" unless @array.first.kind_of?(String)

    parts = @array.first.split('.')
    field = parts[0]
    operator = parts[1]

    value = @array.last

    if 'AND' == field.upcase or 'OR' == field.upcase
      # TODO - to_condition - pass 'AND'|'OR' pair to Hash
      return {field => value}
    end

    unless operator
      # handle implicit .eq ({'name' => 'value'}) or .like ({'name' => 'value%'})
      operator = value.to_s.index('%') ? 'like' : 'eq'
    end
    operator = operator.downcase
    mapped = operator.to_operator
    raise "Unknown operator .#{operator}" unless mapped

    # handle .null or .nnull, suppress value
    return  [field + mapped] if operator.index('null')

    # handle .in (?) or .between ? and ?
    if 'in' == operator or 'between' == operator
      values = value.to_s.split(',').collect { | ea | ea.strip }
      if 'in' == operator
        result = [field + mapped, values]
      else
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

