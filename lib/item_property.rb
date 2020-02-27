# frozen_string_literal: true

require_relative 'item'
require 'delegate'
require_relative 'aged_brie'

# self Property Class responsible for the quality and sell in of the selfs
class ItemProperty < SimpleDelegator
  MAX_QUALITY = 50
  MIN_QUALITY = 0
  DEFAULT_QUALITY_CHANGE = 1
  DEFAULT_SELL_IN_DECREASE = 1

  def self.wrap(item)
    case item.name
    when "Aged Brie"
      AgedBrie.new(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      BackStage.new(item)
    when "Conjured Mana Cake"
      Conjured.new(item)
    when "Sulfuras, Hand of Ragnaros"
      Sulfuras.new(item)
    else
      new(item)
    end
  end

  def condition
    return if name == 'Sulfuras, Hand of Ragnaros'
    decrease_sell_in
    change_quality
  end

  def decrease_sell_in(amount = DEFAULT_SELL_IN_DECREASE)
    self.sell_in -= amount
  end

  def change_quality
    self.quality += calculate_quality
  end

  def calculate_quality
    measure = 0
    sell_in < 0 ? measure -= 1 : measure -= 1
    measure
  end

  def quality=(new_quality)
    new_quality = 0 if new_quality < 0
    new_quality = 50 if new_quality > 50
    # calls a method on the parent class with the same name as the method that calls super
    super(new_quality)
  end

end


class BackStage < ItemProperty
  def calculate_quality
    measure = 1
    measure -= (quality + 3) if sell_in < 0
    measure += 1 if sell_in < 11    
    measure += 1 if sell_in < 6
    measure
  end
end

class Conjured < ItemProperty
  def calculate_quality
    measure = -2
    if sell_in < 0
      measure -= 2
    end
    measure
  end
end

class Sulfuras < ItemProperty
  def calculate_quality
    # No changes with Sulfuras
  end
end

class AgedBrie < ItemProperty
  def calculate_quality
    measure = 1
    if sell_in < 0
      measure += 1
    end
    measure
  end
end
