require 'helpers/hash_helper'

class Hash

  # Extends Hash with a convenience method to HashToConditions::HashHelper
   def to_conditions
    HashToConditions::HashHelper.new(self).to_conditions
  end
end

