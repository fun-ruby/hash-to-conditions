module HashToConditions

# This class performs the bulk of the work. It takes a Hash and return the fully
# expanded Array condition.
#
# For example:
#  > helper = HashHelper.new({'age.gt' => 18})
#  > helper.to_conditions => ['(age>?)', 18] 
#
# Boolean *AND* and *OR* can be used to join multiple conditions.
#
# Examples:
#
#  > helper = HashHelper.new({'AND' => {'name' => 'Lou%', 'age.gt' => 18}})
#  > helper.to_conditions => ['(name LIKE ? AND age>?)', 'Lou%', 18] 
#
#  > helper = HashHelper.new({'name.like' => 'Lou%', 'age.gt' => 18}) - boolean AND is implicit here
#  > helper.to_conditions => ['(name LIKE ? AND age>?)', 'Lou%', 18] 
#
#  > helper = HashHelper.new({'OR' => {'name.like' => 'Lou%', 'age.gt' => 18}})
#  > helper.to_conditions => ['(name LIKE ? OR age>?)', 'Lou%', 18] 
#
# Nested conditions are also supported:
#
#  > nested_h = {'name' => 'Lou%', 'age.gt' => 18}
#  > helper = HashHelper.new({'OR' => {'AND' => nested_h, 'salary.between' => '50k, 100k'}})
#  > helper.to_conditions => ['((name LIKE ? AND age>?) OR salary BETWEEN ? AND ?)', 'Lou%', 18, '50k', '100k'] 
#

class HashHelper

  # Returns a fully expaned condition array
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

    # Performs the translation. Parse @hash, construct the condition @result_s string using boolean
    # operator @join_s. Collect @result_s and condition values in @result_a. An exception is raised,
    # *nested_too_deep_or_cyclic*, when nesting exceeds 42 recursive calls.
    def parse(hash, join_s, result_s, result_a, nest_lev=0)
      raise "nested_too_deep_or_cyclic" unless nest_lev < 42

      result_s << '('
      count = hash.length
      hash.each_pair { | k, v |
        arr = [k, v].to_condition
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

   # Creates a new instance
    def initialize(hash)
      @hash = hash
    end
end

end

