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
    self.quality += amount if self.quality < MAX_QUALITY
  end

  def decrease_quality(amount = DEFAULT_QUALITY_DECREASE)
    self.quality -= amount if self.quality > MIN_QUALITY
  end

  def decrease_sell_in(amount = DEFAULT_SELL_IN_DECREASE)
    self.sell_in -= amount if self.name != 'Sulfuras, Hand of Ragnaros'
  end

  def condition
    decrease_sell_in
    detailed_condition
  end

  def detailed_condition
    if (name != 'Aged Brie') && (name != 'Backstage passes to a TAFKAL80ETC concert')
      decrease_quality if name != 'Sulfuras, Hand of Ragnaros'
    else
      if quality < 50
        increase_quality
        if name == 'Backstage passes to a TAFKAL80ETC concert'
          increase_quality if sell_in < 11
          increase_quality if sell_in < 6
        end
      end
    end
    if sell_in.negative?
      if name != 'Aged Brie'
        if name != 'Backstage passes to a TAFKAL80ETC concert'
          decrease_quality
        else
          decrease_quality(quality)
        end
      else
        increase_quality
      end
    end
  end
end
