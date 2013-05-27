require 'helpers/array_helper'

class Array
  def to_condition
    HashToConditions::ArrayHelper.new(self).to_condition
  end
end

