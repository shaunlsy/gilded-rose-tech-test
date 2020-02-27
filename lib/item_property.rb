# frozen_string_literal: true

require_relative 'item'
require 'delegate'

# self Property Class responsible for the quality and sell in of the selfs
class ItemProperty < SimpleDelegator
  MAX_QUALITY = 50
  MIN_QUALITY = 0
  DEFAULT_QUALITY_INCREASE = 1
  DEFAULT_QUALITY_DECREASE = 1
  DEFAULT_SELL_IN_DECREASE = 1

  def increase_quality(amount = DEFAULT_QUALITY_INCREASE)
    self.quality += amount if quality < MAX_QUALITY
  end

  def decrease_quality(amount = DEFAULT_QUALITY_DECREASE)
    self.quality -= amount if quality > MIN_QUALITY
  end

  def decrease_sell_in(amount = DEFAULT_SELL_IN_DECREASE)
    self.sell_in -= amount
  end

  def condition
    return if name == 'Sulfuras, Hand of Ragnaros'
    decrease_sell_in
    detailed_condition
  end

  def detailed_condition
    if name == 'Aged Brie'
      increase_quality
      increase_quality if sell_in.negative?
    elsif name == 'Backstage passes to a TAFKAL80ETC concert'
      increase_quality
      increase_quality if sell_in < 11
      increase_quality if sell_in < 6
      decrease_quality(quality) if sell_in.negative?
    elsif name == 'Conjured Mana Cake'
      decrease_quality(2* DEFAULT_QUALITY_DECREASE)
      decrease_quality(2* DEFAULT_QUALITY_DECREASE) if sell_in.negative?
    else
      decrease_quality
      decrease_quality if sell_in.negative?
    end
  end

end
