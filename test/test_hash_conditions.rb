require 'test/unit'
require 'hash_to_conditions'

class TestHashCondition < Test::Unit::TestCase

  def test_and_eq
    a = { 'AND' => {:name => 'long'} }.to_conditions
    assert_equal '(name=?)', a[0]
    assert_equal 'long', a[1]
  end

  def test_implicit_and_eq
    a = {:name => 'long'}.to_conditions
    assert_equal '(name=?)', a[0]
    assert_equal 'long', a[1]
  end

  def test_and_two_eq
    a = {'and' => {:name => 'long', :hair_color => 'black'}}.to_conditions
    assert_equal 3, a.length
    assert_equal '(name=? AND hair_color=?)', a[0]
    assert_equal 'long', a[1]
    assert_equal 'black', a[2]
  end

  def test_implicit_and_two_eq
    a = {:name => 'long', :hair_color => 'black'}.to_conditions
    assert_equal 3, a.length
    assert_equal '(name=? AND hair_color=?)', a[0]
    assert_equal 'long', a[1]
    assert_equal 'black', a[2]
  end

  def test_or_two_eq
    a = {'or' => {:name => 'long', :hair_color => 'black'}}.to_conditions
    assert_equal 3, a.length
    assert_equal '(name=? OR hair_color=?)', a[0]
    assert_equal 'long', a[1]
    assert_equal 'black', a[2]
  end

  def test_like
    a = {'name.like' => 'long%'}.to_conditions
    assert_equal '(name LIKE ?)', a[0]
    assert_equal 'long%', a[1]
  end

  def test_ne
    a = {'name.ne' => 'long'}.to_conditions
    assert_equal '(name<>?)', a[0]
    assert_equal 'long', a[1]
  end

  def test_gt
    a = {'age.gt' => 25}.to_conditions
    assert_equal '(age>?)', a[0]
    assert_equal 25, a[1]
  end

  def test_ge
    a = {'age.ge' => 25}.to_conditions
    assert_equal '(age>=?)', a[0]
    assert_equal 25, a[1]
  end

  def test_lt
    a = {'age.lt' => 25}.to_conditions
    assert_equal '(age<?)', a[0]
    assert_equal 25, a[1]
  end

  def test_le
    a = {'age.le' => 25}.to_conditions
    assert_equal '(age<=?)', a[0]
    assert_equal 25, a[1]
  end

  def test_null
    a = {'deleted_at.null' => 'ignored'}.to_conditions
    assert_equal 1, a.length
    assert_equal '(deleted_at IS NULL)', a[0]
  end

  def test_nnull
    a = {'deleted_at.nnull' => 'ignored'}.to_conditions
    assert_equal 1, a.length
    assert_equal '(deleted_at IS NOT NULL)', a[0]
  end

  def test_in
    a = {'order_id.in' => '5, 6, 8'}.to_conditions
    assert_equal '(order_id IN (?))', a[0]
    assert_equal ['5', '6', '8'], a[1]
  end

  def test_between
    a = {'age.between' => '15, 19'}.to_conditions
    assert_equal 3, a.length
    assert_equal '(age BETWEEN ? AND ?)', a[0]
    assert_equal '15', a[1]
    assert_equal '19', a[2]
  end

  def test_nested
    h = {'or' => {
      'And' => {:name => 'long', :hair_color => 'black'},
      'and' => {'age.gt' => 18, 'height.between' => '5,6'}
      } }
    a = h.to_conditions
    assert_equal 6, a.length
    assert_equal '((name=? AND hair_color=?) OR (age>? AND height BETWEEN ? AND ?))', a[0]
    assert_equal 'long', a[1]
    assert_equal 'black', a[2]
    assert_equal 18, a[3]
    assert_equal '5', a[4]
    assert_equal '6', a[5]
  end

  def test_empty_hash
    exception = assert_raise(RuntimeError) {{}.to_conditions}
    assert_equal "empty_condition", exception.message
  end

  def test_cyclic_nesting
    h = {'age.between' => '15, 19'}
    h['OR'] = h
    exception = assert_raise(RuntimeError) {h.to_conditions}
    assert_equal "nested_too_deep_or_cyclic", exception.message
  end

end

