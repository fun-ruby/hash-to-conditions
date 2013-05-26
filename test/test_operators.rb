require 'test/unit'
require 'hash_to_conditions'

class TestOperators < Test::Unit::TestCase

  def test_eq
    assert_equal ' = ', HashToConditions::StringHelper.new('eq').to_operator
    assert_equal ' = ', 'eq'.to_operator
  end

  def test_ne
    assert_equal ' <> ', HashToConditions::StringHelper.new('ne').to_operator
    assert_equal ' <> ', 'ne'.to_operator
  end

  def test_gt
    assert_equal ' > ', HashToConditions::StringHelper.new('gt').to_operator
    assert_equal ' > ', 'gt'.to_operator
  end

  def test_ge
    assert_equal ' >= ', HashToConditions::StringHelper.new('ge').to_operator
    assert_equal ' >= ', 'ge'.to_operator
  end

  def test_lt
    assert_equal ' < ', HashToConditions::StringHelper.new('lt').to_operator
    assert_equal ' < ', 'lt'.to_operator
  end

  def test_le
    assert_equal ' <= ', HashToConditions::StringHelper.new('le').to_operator
    assert_equal ' <= ', 'le'.to_operator
  end

  def test_like
    assert_equal ' LIKE ', HashToConditions::StringHelper.new('like').to_operator
    assert_equal ' LIKE ', 'like'.to_operator
  end

  def test_null
    assert_equal ' IS NULL ', HashToConditions::StringHelper.new('null').to_operator
    assert_equal ' IS NULL ', 'null'.to_operator
  end

  def test_nnull
    assert_equal ' IS NOT NULL ', HashToConditions::StringHelper.new('nnull').to_operator
    assert_equal ' IS NOT NULL ', 'nnull'.to_operator
  end

  def test_in
    assert_equal ' IN ', HashToConditions::StringHelper.new('in').to_operator
    assert_equal ' IN ', 'in'.to_operator
  end

  def test_between
    assert_equal ' BETWEEN ', HashToConditions::StringHelper.new('between').to_operator
    assert_equal ' BETWEEN ', 'between'.to_operator
  end

  def test_undefined
    assert_equal nil, HashToConditions::StringHelper.new('foo').to_operator
    assert_equal nil, 'foo'.to_operator
  end

end

