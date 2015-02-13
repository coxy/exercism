require 'minitest/autorun'
require 'date'
require 'time'

require_relative 'gigasecond'
class GigasecondTest < Minitest::Test
  def test_1
    gs = Gigasecond.from(Time.new(2011, 4, 25))
    assert_equal Time.new(2043, 1, 1, 0 , 46, 40), gs
  end

  def test_2
    gs = Gigasecond.from(Time.new(1977, 6, 13))
    assert_equal Time.new(2009, 2, 19, 0, 46, 40), gs
  end

  def test_3
    gs = Gigasecond.from(Time.new(1959, 7, 19))
    assert_equal Time.new(1991, 3, 27, 0, 46, 40), gs
  end

  def test_time_with_seconds
    gs = Gigasecond.from(Time.new(1959, 7, 19, 23, 59, 59))
    assert_equal Time.new(1991, 3, 28, 0, 46, 39), gs
  end

  # modify the test to test your 1 Gs anniversary
  def test_yourself
    your_birthday = Time.new(1983, 4, 26)
    gs = Gigasecond.from(your_birthday)
    assert_equal Time.new(2015, 01, 02, 0, 46, 40), gs
  end
end
