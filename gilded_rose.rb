require './item.rb'

class GildedRose

  @items = []

  def initialize
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << aged_brie = Item.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << sulfuras = Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << backstage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << conjured_mana_cake = Item.new("Conjured Mana Cake", 3, 6)

    class << sulfuras
      def adapt_sell_in; end
      def adapt_quality; end
    end

    class << aged_brie
      def __apply_quality_change
        if expired?
          self.quality = quality + 2
        else
          self.quality = quality + 1
        end
      end
    end

    class << backstage_pass
      def __apply_quality_change
        if expired?
          self.quality = 0
        elsif self.sell_in < 5
          self.quality = quality + 3
        elsif self.sell_in < 10
          self.quality = quality + 2
        else
          self.quality = quality + 1
        end
      end
    end

    class << conjured_mana_cake
      def __apply_quality_change
        if expired?
          self.quality = self.quality - 4
        else
          self.quality = self.quality - 2
        end
      end
    end
  end

  def update_quality
    @items.each do |current_item|
      current_item.adapt_sell_in
      current_item.adapt_quality
    end
  end

end
