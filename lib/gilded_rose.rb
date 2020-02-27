# frozen_string_literal: true

require_relative 'item_property'
class GildedRose < ItemProperty

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
     condition(item)
    end
  end

end
