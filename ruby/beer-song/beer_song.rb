# beer_song.rb
class BeerSong
  attr_reader :stock_level

  def verse(number)
    @stock_level = number
    build_verse
  end

  def verses(from, to)
    from.downto(to).map do |number|
      verse(number) + "\n"
    end.join
  end

  def sing
    verses(max_beers, 0)
  end

  private

  def max_beers
    99
  end

  def build_verse
    [before, action, after].join
  end

  def before
    sing_about(:what_weve_got).capitalize
  end

  def action
    sing_about(:what_were_doing)
  end

  def after
    drink_or_restock
    sing_about(:what_weve_got_now)
  end

  def drink_or_restock
    @stock_level = (@stock_level - 1) % 100
  end

  def sing_about(key)
    fragment = merged_fragments[key]
    return fragment.to_s unless fragment.is_a?(String)
    fragment.gsub(/:[a-z_]+/) do |fragment_key|
      sing_about(fragment_key[1..-1].to_sym)
    end
  end
  
  def default_fragments
    fragments[:default].merge(stock_level: stock_level)
  end

  def stock_level_specific_fragments
    fragments[:"when_#{stock_level}"] || {}
  end

  def merged_fragments
    default_fragments.merge(stock_level_specific_fragments)
  end

  def fragments
    {
      default: {
        what_weve_got: ":bottles_on_wall, :bottles_of_beer.\n",
        what_were_doing: 'Take :take_what down and pass it around',
        what_weve_got_now: ", :bottles_on_wall.\n",
        bottles_of_beer: ':bottle_count :bottles of beer',
        bottles_on_wall: ':bottles_of_beer on the wall',
        bottle_count: ':stock_level',
        bottles: 'bottles',
        take_what: 'one'
      },
      when_1: {
        bottles: 'bottle',
        take_what: 'it'
      },
      when_0: {
        what_were_doing: 'Go to the store and buy some more',
        bottle_count: 'no more'
      }
    }
  end
end
