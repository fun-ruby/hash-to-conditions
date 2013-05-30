require 'helpers/array_helper'

class Array

  # Extends Array with a convenience method to HashToConditions::ArrayHelper
  def to_condition
    HashToConditions::ArrayHelper.new(self).to_condition
  end
end

