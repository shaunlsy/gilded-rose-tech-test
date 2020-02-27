# frozen_string_literal: true

require_relative 'item'
require 'delegate'

# self Property Class responsible for the quality and sell in of the selfs
class ItemProperty < SimpleDelegator
  MAX_QUALITY = 50
  MIN_QUALITY = 0
  DEFAULT_QUALITY_CHANGE = 1
  DEFAULT_SELL_IN_DECREASE = 1

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
    if name == 'Aged Brie'
      measure += DEFAULT_QUALITY_CHANGE
      measure += DEFAULT_QUALITY_CHANGE if sell_in.negative?
    elsif name == 'Backstage passes to a TAFKAL80ETC concert'
      measure += DEFAULT_QUALITY_CHANGE
      measure += DEFAULT_QUALITY_CHANGE if sell_in < 11
      measure += DEFAULT_QUALITY_CHANGE if sell_in < 6
      measure -= (quality+3) if sell_in.negative?
    elsif name == 'Conjured Mana Cake'
      measure -= 2 * DEFAULT_QUALITY_CHANGE
      measure -= 2 * DEFAULT_QUALITY_CHANGE if sell_in.negative?
    else
      measure -= DEFAULT_QUALITY_CHANGE
      measure -= DEFAULT_QUALITY_CHANGE if sell_in.negative?
    end
    measure
  end

  def quality=(new_quality)
    new_quality = 0 if new_quality < 0
    new_quality = 50 if new_quality > 50
    # calls a method on the parent class with the same name as the method that calls super
    super(new_quality)
  end

end
