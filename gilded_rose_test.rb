# encoding: utf-8

require './gilded_rose.rb'

require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use!


class GildedRose
  attr_reader :items
end

describe GildedRose do

  let(:subject) { GildedRose.new }
  #- All items have a SellIn value which denotes the number of days we have to
  #  sell the item
  #
  #- All items have a Quality value which denotes how valuable the item is
  #
  #- At the end of each day our system lowers both values for every item

  it "has fixed initial quality data" do
    subject.items.map { |item| item.quality}.must_equal [20, 0, 7, 80, 20, 6]
  end

  describe "#update_quality" do
    it "lowers sell_in value for every item at the end of each day" do
      sell_in_before = subject.items.map { |item| item.sell_in }
      expected_sell_in = sell_in_before.map {|sell_in_value| sell_in_value > 0 ? sell_in_value - 1 : 0}

      subject.update_quality

      subject.items.map { |item| item.sell_in }.must_equal expected_sell_in
    end

    it "lowers quality value for every item at the end of each day" do
      subject.update_quality

      subject.items.map { |item| item.quality }.must_equal [19, 1, 6, 80, 21, 5]
    end
  end

  #- Once the sell by date has passed, Quality degrades twice as fast
  #
  #- The Quality of an item is never negative
  #
  #- "Aged Brie" actually increases in Quality the older it gets
  #
  #- The Quality of an item is never more than 50
  #
  #- "Sulfuras", being a legendary item, never has to be sold or decreases in
  #  Quality
  #
  #- "Backstage passes", like aged brie, increases in Quality as it's SellIn
  #  value approaches; Quality increases by 2 when there are 10 days or less
  #  and by 3 when there are 5 days or less but Quality drops to 0 after the
  #  concert

end
