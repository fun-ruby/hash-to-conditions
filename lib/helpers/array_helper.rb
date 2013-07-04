module HashToConditions

# This helper class takes a Hash key-value pair (an Array) and return the expanded form condition.
#
# For example:
#  > helper = ArrayHelper.new(['age.gt', 18])
#  > helper.to_condition => ['age>?', 18] 

class ArrayHelper

  # Returns an expanded form condition or a Hash if it is a nested condition.
  #
  # An exception is raised when specific validation fails. Possible exception messages are:
  #
  # * '*bad_key_value_pair*' - array must have exactly two (2) elements
  # * '*field_cannot_be_empty*' - a field name must be specified
  # * '*unknown_operator*' - operator tag is not supported
  def to_condition
    raise "bad_key_value_pair" unless @array.length == 2

    parts = @array.first.to_s.split('.')
    raise "field_cannot_be_empty" if parts.empty?

    field = parts[0].strip.to_s
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
    operator = operator.to_s.downcase
    mapped = operator.to_operator
    raise "unknown_operator" unless mapped

    # handle .null or .nnull, suppress value
    return  [field + mapped] if operator.index('null')

    return [field + mapped, value] unless ['in', 'between'].index(operator)

    handle_in_between(operator, field, mapped, value)
  end


  protected

    # Creates a new instance
    def initialize(array)
      @array = array
    end


  private

    # Handle .in (?) or .between ? and ?
    # Return an expanded Array condition
    #
    def handle_in_between(operator, field, mapped_operator, csv)
      values = csv.to_s.split(',').collect { | ea | ea.strip }
      if 'in' == operator
        result = [field + mapped_operator, values]
      else
        # between
        result = [field + mapped_operator, values[0], values[1]]
      end
      result
    end

end

end

