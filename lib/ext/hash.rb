require 'helpers/hash_helper'

class Hash
  def to_conditions
    HashToConditions::HashHelper.new(self).to_conditions
  end
end

