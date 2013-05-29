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

  def test_and_like
    a = { 'AND' => {'name.like' => 'long%'} }.to_conditions
    assert_equal '(name LIKE ?)', a[0]
    assert_equal 'long%', a[1]
  end

  def test_and_two_eq
    a = {'and' => {:name => 'long%', :hair_color => 'black'}}.to_conditions
    assert_equal 3, a.length
    assert_equal '(name LIKE ? AND hair_color=?)', a[0]
    assert_equal 'long%', a[1]
    assert_equal 'black', a[2]
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

end

