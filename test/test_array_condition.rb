require 'test/unit'
require 'hash_to_conditions'

class TestArrayCondition < Test::Unit::TestCase

  def test_implicit_eq
    a = ['name', 'long'].to_condition
    assert_equal 2, a.length
    assert_equal 'name=?', a[0]
    assert_equal 'long', a[1]
  end

  def test_implicit_eq_sym
    a = [:name, 'long'].to_condition
    assert_equal 'name=?', a[0]
    assert_equal 'long', a[1]
  end

  def test_number_as_string_elements
    a = ['1', 2].to_condition
    assert_equal '1=?', a[0]
    assert_equal 2, a[1]
  end

  def test_number_elements
    a = [1, 2].to_condition
    assert_equal '1=?', a[0]
    assert_equal 2, a[1]
  end

  def test_implicit_like
    a = ['name', 'long%'].to_condition
    assert_equal 'name LIKE ?', a[0]
    assert_equal 'long%', a[1]
  end

  def test_eq
    a = ['name.eq', 'long'].to_condition
    assert_equal 2, a.length
    assert_equal 'name=?', a[0]
    assert_equal 'long', a[1]
  end

  def test_eq_sym
    a = [:'name.eq', 'long'].to_condition
    assert_equal 'name=?', a[0]
    assert_equal 'long', a[1]
  end

  def test_like
    a = ['name.like', 'long%'].to_condition
    assert_equal 'name LIKE ?', a[0]
    assert_equal 'long%', a[1]
  end

  def test_ne
    a = ['name.ne', 'long'].to_condition
    assert_equal 'name<>?', a[0]
    assert_equal 'long', a[1]
  end

  def test_gt
    a = ['age.gt', '18'].to_condition
    assert_equal 'age>?', a[0]
    assert_equal '18', a[1]
  end

  def test_ge
    a = ['age.ge', '18'].to_condition
    assert_equal 'age>=?', a[0]
    assert_equal '18', a[1]
  end

  def test_lt
    a = ['age.lt', '18'].to_condition
    assert_equal 'age<?', a[0]
    assert_equal '18', a[1]
  end

  def test_le
    a = ['age.le', '18'].to_condition
    assert_equal 'age<=?', a[0]
    assert_equal '18', a[1]
  end

  def test_null
    a = ['deleted_at.null', 'ignored'].to_condition
    assert_equal 'deleted_at IS NULL', a[0]
    assert_equal 1, a.length
  end

  def test_nnull
    a = ['deleted_at.nnull', 'ignored'].to_condition
    assert_equal 'deleted_at IS NOT NULL', a[0]
    assert_equal 1, a.length
  end

  def test_in
    a = ['order_id.in', '3, 4, 6, 8, 10'].to_condition
    assert_equal 2, a.length
    assert_equal 'order_id IN (?)', a[0]
    assert_equal ['3', '4', '6', '8', '10'], a[1]
  end

  def test_between
    a = ['order_id.between', '4, 8'].to_condition
    assert_equal 3, a.length
    assert_equal 'order_id BETWEEN ? AND ?', a[0]
    assert_equal '4', a[1]
    assert_equal '8', a[2]
  end

  def test_empty_array
    exception = assert_raise(RuntimeError) {[].to_condition}
    assert_equal "bad_key_value_pair", exception.message
  end

  def test_size1_array
    exception = assert_raise(RuntimeError) {[1].to_condition}
    assert_equal "bad_key_value_pair", exception.message
  end

  def test_size3_array
    exception = assert_raise(RuntimeError) {[1, 2, 3].to_condition}
    assert_equal "bad_key_value_pair", exception.message
  end

  def test_empty_field
    exception = assert_raise(RuntimeError) {['', 'foo'].to_condition}
    assert_equal "field_cannot_be_empty", exception.message
  end

end

