require 'test/unit'
require 'hash_to_conditions'

class TestOperators < Test::Unit::TestCase

  def test_eq
    assert_equal '=?', 'eq'.to_operator
  end

  def test_ne
    assert_equal '<>?', 'ne'.to_operator
  end

  def test_gt
    assert_equal '>?', 'gt'.to_operator
  end

  def test_ge
    assert_equal '>=?', 'ge'.to_operator
  end

  def test_lt
    assert_equal '<?', 'lt'.to_operator
  end

  def test_le
    assert_equal '<=?', 'le'.to_operator
  end

  def test_like
    assert_equal ' LIKE ?', 'like'.to_operator
  end

  def test_null
    assert_equal ' IS NULL', 'null'.to_operator
  end

  def test_nnull
    assert_equal ' IS NOT NULL', 'nnull'.to_operator
  end

  def test_in
    assert_equal ' IN (?)', 'in'.to_operator
  end

  def test_between
    assert_equal ' BETWEEN ? AND ?', 'between'.to_operator
  end

  def test_undefined
    assert_equal nil, 'foo'.to_operator
  end

end

