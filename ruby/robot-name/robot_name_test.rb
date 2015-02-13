require 'minitest/autorun'
require_relative 'robot'

class RobotTest < MiniTest::Unit::TestCase
  def test_has_name
    # rubocop:disable Lint/AmbiguousRegexpLiteral
    assert_match /^[A-Z]{2}\d{3}$/, Robot.new.name
    # rubocop:enable Lint/AmbiguousRegexpLiteral
  end

  def test_name_sticks
    robot = Robot.new
    robot.name
    assert_equal robot.name, robot.name
  end

  def test_different_robots_have_different_names
    # rubocop:disable Lint/UselessComparison
    assert Robot.new.name != Robot.new.name
    # rubocop:enable Lint/UselessComparison
  end

  def test_should_not_repeat_names
    Robot.reset_names
    robot = Robot.new
    675999.times do
      new_robot = Robot.new
      assert robot.name != new_robot.name
      robot = new_robot
    end
    assert_equal 'NAMELESS', Robot.new.name
    Robot.reset_names
  end

  def test_reset_name
    robot = Robot.new
    name = robot.name
    robot.reset
    name2 = robot.name
    assert name != name2
    # rubocop:disable Lint/AmbiguousRegexpLiteral
    assert_match /^[A-Z]{2}\d{3}$/, name2
    # rubocop:enable Lint/AmbiguousRegexpLiteral
  end
end
