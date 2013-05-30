require 'helpers/string_helper'

class String

  # Extends String with a convenience method to HashToConditions::StringHelper
  def to_operator
    HashToConditions::StringHelper.new(self).to_operator
  end
end

