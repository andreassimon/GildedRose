require './item.rb'

class GildedRose

  @items = []

  def initialize
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << Item.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)
  end

  def update_quality

    @items.each do |current_item|
      if current_item.name == "Aged Brie"
        current_item.quality = current_item.quality + 1
        current_item.quality = [50, current_item.quality].min
      elsif current_item.name == "Backstage passes to a TAFKAL80ETC concert"
        current_item.quality = current_item.quality + 1
        if current_item.sell_in < 11
          current_item.quality = current_item.quality + 1
        end
        if current_item.sell_in < 6
          current_item.quality = current_item.quality + 1
        end
        current_item.quality = [50, current_item.quality].min
      elsif current_item.name == "Sulfuras, Hand of Ragnaros"
        current_item.quality = current_item.quality
      else
        current_item.quality = [0, current_item.quality - 1].max
      end
      if current_item.name != "Sulfuras, Hand of Ragnaros"
        current_item.sell_in = current_item.sell_in - 1
      end
      if current_item.sell_in < 0
        case current_item.name
        when "Aged Brie"
          current_item.quality = [50, current_item.quality + 1].min
        when "Backstage passes to a TAFKAL80ETC concert"
          current_item.quality = 0
        when "Sulfuras, Hand of Ragnaros"
          current_item.quality = current_item.quality
        else
          current_item.quality = [0, current_item.quality - 1].max
        end
      end
    end
  end

end
