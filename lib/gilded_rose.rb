class GildedRose

  def initialize(items)
    @items = items
  end

  def normal_update(item)
    item.quality -= 1
    item.quality -= 1 if item.sell_in <= 0
    item.quality = 0 if item.quality < 0
    item.sell_in -= 1
  end

  def brie_update(item)
    item.quality += 1
    item.quality += 1 if item.sell_in <= 0
    item.quality = 50 if item.quality > 50
    item.sell_in -= 1
  end

  def pass_update(item)
    item.quality += 1
    item.quality += 1 if item.sell_in <= 10
    item.quality += 1 if item.sell_in <= 5
    item.quality = 50 if item.quality > 50
    item.quality = 0 if item.sell_in <= 0
    item.sell_in -= 1
  end

  def update_quality()
    @items.each do |item|
      if item.name == "foo"
        return normal_update(item)
      end
      if item.name == "Aged Brie"
        return brie_update(item)
      end
      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        return pass_update(item)
      end
      if item.name == "Sulfuras, Hand of Ragnaros"
        return
      end
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
