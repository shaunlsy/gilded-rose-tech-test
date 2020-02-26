require File.join(File.dirname(__FILE__), '../lib/gilded_rose')

describe GildedRose do
  let(:foo){ Item.new("foo", 0, 0)}
  let(:ramen){ Item.new("ramen", 5, 5)}
  let(:aged_brie){ Item.new("Aged Brie", 6, 6)}
  let(:aged_brie_quality_no_more_than_50){ Item.new("Aged Brie", 5, 49)}
  let(:items){ [foo, ramen, aged_brie, aged_brie_quality_no_more_than_50]}

  describe "#update_quality" do
    it "does not change the name" do
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "reduces the sell_in and quality of the ramen" do
      GildedRose.new(items).update_quality()
      expect(items[1].name).to eq "ramen"
      expect(items[1].quality).to eq 4
      expect(items[1].sell_in).to eq 4

      GildedRose.new(items).update_quality()
      expect(items[1].name).to eq "ramen"
      expect(items[1].quality).to eq 3
      expect(items[1].sell_in).to eq 3
    end

    it "reduces the sell_in and increases quality of the Aged Brie" do
      GildedRose.new(items).update_quality()
      expect(items[2].name).to eq "Aged Brie"
      expect(items[2].quality).to eq 7
      expect(items[2].sell_in).to eq 5

      GildedRose.new(items).update_quality()
      expect(items[2].name).to eq "Aged Brie"
      expect(items[2].quality).to eq 8
      expect(items[2].sell_in).to eq 4
    end

    it "makes sure the quality of an item is never more than 50" do
      GildedRose.new(items).update_quality()
      expect(items[3].name).to eq "Aged Brie"
      expect(items[3].quality).to eq 50
      expect(items[3].sell_in).to eq 4

      GildedRose.new(items).update_quality()
      expect(items[3].name).to eq "Aged Brie"
      expect(items[3].quality).to eq 50
      expect(items[3].sell_in).to eq 3

      10.times { GildedRose.new(items).update_quality() }
      expect(items[3].name).to eq "Aged Brie"
      expect(items[3].quality).to eq 50
      expect(items[3].sell_in).to eq -7
    end

  end

end
