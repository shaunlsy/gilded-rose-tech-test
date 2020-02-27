# frozen_string_literal: true
require_relative 'item_property'
require_relative 'item'
require_relative 'aged_brie'
require_relative 'backstage'
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      ItemProperty.wrap(item).condition
    end
  end
end
