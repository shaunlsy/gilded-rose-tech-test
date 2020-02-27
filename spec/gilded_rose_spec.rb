# frozen_string_literal: true
require 'spec_helper'
require File.join(File.dirname(__FILE__), '../lib/gilded_rose')

describe GildedRose do
  let(:foo) { Item.new('foo', 0, 0) }
  let(:ramen) { Item.new('ramen', 5, 5) }
  let(:aged_brie) { Item.new('Aged Brie', 6, 6) }
  let(:aged_brie_negative_sell_in) { Item.new('Aged Brie', 1, 1) }
  let(:aged_brie_quality_no_more_than_50) { Item.new('Aged Brie', 5, 49) }
  let(:sulfuras) { Item.new('Sulfuras, Hand of Ragnaros', 10, 10) }
  let(:backstage) { Item.new('Backstage passes to a TAFKAL80ETC concert', 20, 20) }
  let(:backstage_less_than_10_sell_in) { Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 20) }
  let(:backstage_less_than_5_sell_in) { Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 20) }
  let(:backstage_less_than_1_sell_in) { Item.new('Backstage passes to a TAFKAL80ETC concert', 1, 20) }
  let(:conjured) { Item.new('Conjured Mana Cake', 20, 20) }
  let(:items) { [foo, ramen, aged_brie, aged_brie_negative_sell_in, aged_brie_quality_no_more_than_50, sulfuras, backstage, backstage_less_than_10_sell_in, backstage_less_than_5_sell_in, backstage_less_than_1_sell_in, conjured] }

  before(:each) do
    GildedRose.new(items).update_quality
  end

  describe '#update_quality' do
    it 'does not change the name' do
      expect(items[0].name).to eq 'foo'
    end

    it 'reduces the sell_in and quality of the ramen' do
      expect(items[1].name).to eq 'ramen'
      expect(items[1].quality).to eq 4
      expect(items[1].sell_in).to eq 4

      GildedRose.new(items).update_quality
      expect(items[1].name).to eq 'ramen'
      expect(items[1].quality).to eq 3
      expect(items[1].sell_in).to eq 3
    end

    it 'reduces the sell_in and increases quality of the Aged Brie' do
      expect(items[2].name).to eq 'Aged Brie'
      expect(items[2].quality).to eq 7
      expect(items[2].sell_in).to eq 5

      GildedRose.new(items).update_quality
      expect(items[2].name).to eq 'Aged Brie'
      expect(items[2].quality).to eq 8
      expect(items[2].sell_in).to eq 4
    end

    it 'degrades the quality of Aged Brie once the sell by date has passed' do
      expect(items[3].name).to eq 'Aged Brie'
      expect(items[3].quality).to eq 2
      expect(items[3].sell_in).to eq 0

      GildedRose.new(items).update_quality
      expect(items[3].name).to eq 'Aged Brie'
      expect(items[3].quality).to eq 4
      expect(items[3].sell_in).to eq -1

      GildedRose.new(items).update_quality
      expect(items[3].name).to eq 'Aged Brie'
      expect(items[3].quality).to eq 6
      expect(items[3].sell_in).to eq -2
    end

    it 'makes sure the quality of Aged Brie is never more than 50' do
      expect(items[4].name).to eq 'Aged Brie'
      expect(items[4].quality).to eq 50
      expect(items[4].sell_in).to eq 4

      GildedRose.new(items).update_quality
      expect(items[4].name).to eq 'Aged Brie'
      expect(items[4].quality).to eq 50
      expect(items[4].sell_in).to eq 3

      10.times { GildedRose.new(items).update_quality }
      expect(items[4].name).to eq 'Aged Brie'
      expect(items[4].quality).to eq 50
      expect(items[4].sell_in).to eq -7
    end

    it 'maintains the quality and sell_in value of Sulfuras' do
      expect(items[5].name).to eq 'Sulfuras, Hand of Ragnaros'
      expect(items[5].quality).to eq 10
      expect(items[5].sell_in).to eq 10

      GildedRose.new(items).update_quality
      expect(items[5].name).to eq 'Sulfuras, Hand of Ragnaros'
      expect(items[5].quality).to eq 10
      expect(items[5].sell_in).to eq 10
    end

    it 'reduces the sell_in and increases quality of the Backstage passes 20, 20' do
      expect(items[6].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
      expect(items[6].quality).to eq 21
      expect(items[6].sell_in).to eq 19

      GildedRose.new(items).update_quality
      expect(items[6].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
      expect(items[6].quality).to eq 22
      expect(items[6].sell_in).to eq 18
    end

    it 'reduces the sell_in and increases quality of the Backstage passes 10, 20 twice when there are 10 days or less' do
      expect(items[7].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
      expect(items[7].quality).to eq 22
      expect(items[7].sell_in).to eq 9

      GildedRose.new(items).update_quality
      expect(items[7].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
      expect(items[7].quality).to eq 24
      expect(items[7].sell_in).to eq 8
    end

    it 'reduces the sell_in and increases quality of the Backstage passes twice 5, 20 when there are 5 days or less' do
      expect(items[8].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
      expect(items[8].quality).to eq 23
      expect(items[8].sell_in).to eq 4

      GildedRose.new(items).update_quality
      expect(items[8].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
      expect(items[8].quality).to eq 26
      expect(items[8].sell_in).to eq 3
    end

    it 'drops the quality of the Backstage to 0 1, 20 after the concert' do
      expect(items[9].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
      expect(items[9].quality).to eq 23
      expect(items[9].sell_in).to eq 0
      GildedRose.new(items).update_quality
      expect(items[9].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
      expect(items[9].quality).to eq 0
      expect(items[9].sell_in).to eq -1

      GildedRose.new(items).update_quality
      expect(items[9].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
      expect(items[9].quality).to eq 0
      expect(items[9].sell_in).to eq -2
    end

    it 'degrades the quality of conjured items 20,20 twice as fast as normal items' do
      expect(items[10].name).to eq 'Conjured Mana Cake'
      expect(items[10].quality).to eq 18
      expect(items[10].sell_in).to eq 19

      GildedRose.new(items).update_quality
      expect(items[10].name).to eq 'Conjured Mana Cake'
      expect(items[10].quality).to eq 16
      expect(items[10].sell_in).to eq 18
    end
  end
end
