# frozen_string_literal: true

require_relative 'item_property'
class GildedRose < ItemProperty
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      ItemProperty.wrap(item).condition
    end
  end
end
