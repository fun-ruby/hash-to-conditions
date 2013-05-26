module HashToConditions

class StringHelper
  @@operators = {
        'eq' => ' = ',
        'ne' => ' <> ',
        'gt' => ' > ',
        'ge' => ' >= ',
        'lt' => ' < ',
        'le' => ' <= ',
        'like' => ' LIKE ',
        'null' => ' IS NULL ',
        'nnull' => ' IS NOT NULL ',
        'in' => ' IN ',
        'between' => ' BETWEEN '
      }

  #
  # Returns a matching SQL operator for @string, or nil
  #
  def to_operator
    @@operators[@string]
  end


  protected

    def initialize(string)
      @string = string
    end
end

end

