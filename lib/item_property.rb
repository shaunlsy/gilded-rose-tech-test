require_relative 'item'

class ItemProperty
  MAX_QUALITY = 50
  MIN_QUALITY = 0
  DEFAULT_QUALITY_INCREASE = 1
  DEFAULT_QUALITY_DECREASE = 1
  DEFAULT_SELL_IN_DECREASE = 1

  def increase_quality(item, amount=DEFAULT_QUALITY_INCREASE)
    item.quality += amount if item.quality < MAX_QUALITY
  end

  def decrease_quality(item, amount=DEFAULT_QUALITY_DECREASE)
    item.quality -= amount if item.quality > MIN_QUALITY
  end

  def decrease_sell_in(item, amount=DEFAULT_SELL_IN_DECREASE)
    item.sell_in -= amount
  end

  def condition(item)
    if (item.name != 'Aged Brie') && (item.name != 'Backstage passes to a TAFKAL80ETC concert')
      decrease_quality(item) if item.name != 'Sulfuras, Hand of Ragnaros'
    else
      if item.quality < 50
        increase_quality(item)
        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
          increase_quality(item) if item.sell_in < 11
          increase_quality(item) if item.sell_in < 6 
        end
      end
    end
    decrease_sell_in(item) if item.name != 'Sulfuras, Hand of Ragnaros'
    if item.sell_in < 0
      if item.name != 'Aged Brie'
        if item.name != 'Backstage passes to a TAFKAL80ETC concert'
          decrease_quality(item) if item.name != 'Sulfuras, Hand of Ragnaros'
        else
          decrease_quality(item, item.quality)
        end
      else
        increase_quality(item)
      end
    end
  end

end
