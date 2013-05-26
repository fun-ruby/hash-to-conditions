require 'helpers/string_helper'

class String
  def to_operator
    HashToConditions::StringHelper.new(self).to_operator
  end
end

