# encoding: utf-8

class Item

  attr_accessor :name, :sell_in, :quality
        
  def initialize (name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def adapt_sell_in
    self.sell_in = self.sell_in - 1
  end

  def adapt_quality
    __apply_quality_change()
    self.quality = [0, self.quality].max
    self.quality = [50, self.quality].min
  end

  def __apply_quality_change
    if expired?
      self.quality = self.quality - 2
    else
      self.quality = self.quality - 1
    end
  end

  def expired?
    sell_in < 0
  end
end
