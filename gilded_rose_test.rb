# encoding: utf-8

require './gilded_rose.rb'

require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use!


class GildedRose
  attr_reader :items
end

describe 'Golden master' do
  let(:subject) { GildedRose.new }

  expected_sell_dates = [
    [9, 1, 4, 0, 14, 2],
    [8, 0, 3, 0, 13, 1],
    [7, -1, 2, 0, 12, 0],
    [6, -2, 1, 0, 11, -1],
    [5, -3, 0, 0, 10, -2],
    [4, -4, -1, 0, 9, -3],
    [3, -5, -2, 0, 8, -4],
    [2, -6, -3, 0, 7, -5],
    [1, -7, -4, 0, 6, -6],
    [0, -8, -5, 0, 5, -7],
    [-1, -9, -6, 0, 4, -8],
    [-2, -10, -7, 0, 3, -9],
    [-3, -11, -8, 0, 2, -10],
    [-4, -12, -9, 0, 1, -11],
    [-5, -13, -10, 0, 0, -12],
    [-6, -14, -11, 0, -1, -13],
    [-7, -15, -12, 0, -2, -14],
    [-8, -16, -13, 0, -3, -15],
    [-9, -17, -14, 0, -4, -16],
    [-10, -18, -15, 0, -5, -17]
  ]

  (1..expected_sell_dates.size).each do |evolution|
    it "the #{evolution}. evolution has sell dates #{expected_sell_dates[evolution - 1].inspect}" do
      evolution.times { subject.update_quality }
      subject.items.map(&:sell_in).must_equal expected_sell_dates[evolution - 1]
    end
  end

  expected_qualities = [
    [19, 1, 6, 80, 21, 5],
    [18, 2, 5, 80, 22, 4],
    [17, 4, 4, 80, 23, 3],
    [16, 6, 3, 80, 24, 1],
    [15, 8, 2, 80, 25, 0],
    [14, 10, 0, 80, 27, 0],
    [13, 12, 0, 80, 29, 0],
    [12, 14, 0, 80, 31, 0],
    [11, 16, 0, 80, 33, 0],
    [10, 18, 0, 80, 35, 0],
    [8, 20, 0, 80, 38, 0],
    [6, 22, 0, 80, 41, 0],
    [4, 24, 0, 80, 44, 0],
    [2, 26, 0, 80, 47, 0],
    [0, 28, 0, 80, 50, 0],
    [0, 30, 0, 80, 0, 0],
    [0, 32, 0, 80, 0, 0],
    [0, 34, 0, 80, 0, 0],
    [0, 36, 0, 80, 0, 0],
    [0, 38, 0, 80, 0, 0],
    [0, 40, 0, 80, 0, 0],
    [0, 42, 0, 80, 0, 0],
    [0, 44, 0, 80, 0, 0],
    [0, 46, 0, 80, 0, 0],
    [0, 48, 0, 80, 0, 0],
    [0, 50, 0, 80, 0, 0],
    [0, 50, 0, 80, 0, 0]
  ]

  (1..expected_qualities.size).each do |evolution|
    it "the #{evolution}. evolution has expected qualities #{expected_qualities[evolution - 1].inspect}" do
      evolution.times { subject.update_quality }
      subject.items.map(&:quality).must_equal expected_qualities[evolution - 1]
    end
  end

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
      sell_in_before = subject.items.map(&:sell_in)
      expected_sell_in = sell_in_before.map { |sell_in_value| [0, sell_in_value - 1].max }

      subject.update_quality

      subject.items.map(&:sell_in).must_equal expected_sell_in
    end

    it "lowers quality value for every item at the end of each day" do
      subject.update_quality

      subject.items.map(&:quality).must_equal [19, 1, 6, 80, 21, 5]
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
