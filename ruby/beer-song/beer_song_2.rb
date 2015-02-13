# beer_song.rb
class BeerSong
  attr_reader :bottle_count

  def verse(number)
    @bottle_count = number
    build_verse
  end

  def verses(from, to)
    from.downto(to).map do |verse_number|
      verse(verse_number) + "\n"
    end.join
  end

  def sing
    verses(99, 0)
  end

  private

  def build_verse
    "#{before}\n#{action}, #{after}.\n"
  end

  def select(options = {})
    options[bottle_count] || options[:default]
  end

  def before
    "#{bottles_on_the_wall.capitalize}, #{bottles_of_beer}."
  end

  def action
    select default: "Take #{take_what} down and pass it around",
               0 => 'Go to the store and buy some more'
  end

  def after
    @bottle_count -= 1
    bottles_on_the_wall
  end

  def num_bottles
    select default: bottle_count, 0 => 'no more', -1 => '99'
  end

  def bottle_or_bottles
    select default: 'bottles', 1 => 'bottle'
  end

  def bottles_of_beer
    "#{num_bottles} #{bottle_or_bottles} of beer"
  end

  def bottles_on_the_wall
    "#{bottles_of_beer} on the wall"
  end

  def take_what
    select default: 'one', 1 => 'it'
  end
end
