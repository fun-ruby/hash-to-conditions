module HashToConditions

# This helper class takes an operator tag and convert it to an equivalent SQL operator.
#
# For example:
#  > helper = StringHelper.new('null')
#  > helper.to_operator => ' IS NULL'
#
# Supported operator tags:
#
# <table style=\"border-collapse:collapse; border: 1px solid \#999\">
# <tr>
# <th style=\"border: 1px solid \#999; width: 80px\">Tag</th>
# <th style=\"border: 1px solid \#999; width: 100px\">Output</th>
# </tr>
# <tr>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">eq</td>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">=</td>
# </tr>
# <tr>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">ne</td>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">\<\></td>
# </tr>
# <tr>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">gt</td>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">\></td>
# </tr>
# <tr>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">ge</td>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">\>=</td>
# </tr>
# <tr>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">lt</td>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">\<</td>
# </tr>
# <tr>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">le</td>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">\<=</td>
# </tr>
# <tr>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">like</td>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">LIKE</td>
# </tr>
# <tr>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">null</td>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">IS NULL</td>
# </tr>
# <tr>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">nnull</td>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">IS NOT NULL</td>
# </tr>
# <tr>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">in</td>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">IN</td>
# </tr>
# <tr>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">between</td>
# <td style=\"border: 1px solid \#999; padding-left: 4px\">BETWEEN</td>
# </tr>
# </table>

class StringHelper
  @@operators = {
        'eq' => '=?',
        'ne' => '<>?',
        'gt' => '>?',
        'ge' => '>=?',
        'lt' => '<?',
        'le' => '<=?',
        'like' => ' LIKE ?',
        'null' => ' IS NULL',
        'nnull' => ' IS NOT NULL',
        'in' => ' IN (?)',
        'between' => ' BETWEEN ? AND ?'
      }


  # Returns a matching SQL operator for @string, or nil if none found.
  def to_operator
    @@operators[@string.downcase]
  end


  protected

    # Creates a new instance
    def initialize(string)
      @string = string
    end
end

end

