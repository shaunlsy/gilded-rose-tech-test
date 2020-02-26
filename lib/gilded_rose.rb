require_relative "item"
class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          item.quality = item.quality - 1 if item.name != "Sulfuras, Hand of Ragnaros"
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              item.quality = item.quality + 1 if item.quality < 50
            end
            if item.sell_in < 6
              item.quality = item.quality + 1 if item.quality < 50
            end
          end
        end
      end
      item.sell_in = item.sell_in - 1 if item.name != "Sulfuras, Hand of Ragnaros"
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              item.quality = item.quality - 1 if item.name != "Sulfuras, Hand of Ragnaros"
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          item.quality = item.quality + 1 if item.quality < 50
        end
      end
    end
  end
end
