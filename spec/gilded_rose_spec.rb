require('gilded_rose')

describe GildedRose do

  describe "#update_quality" do

    before :each do
      @items = [Item.new("foo", 5, 4)]
      @subject = GildedRose.new(@items)
    end

    it "does not change the name" do
      @subject.update_quality()
      expect(@items[0].name).to eq "foo"
    end

    context "while SellIn >= 0" do

      it "lowers the Quality value by 1" do
        @subject.update_quality()
        expect(@items[0].quality).to eq 3
      end

      it "lowers the SellIn value by 1" do
        @subject.update_quality()
        expect(@items[0].sell_in).to eq 4
      end

      context "if the item is Aged Brie" do

        before :each do
          @items = [Item.new("Aged Brie", 5, 5)]
          @subject = GildedRose.new(@items)
        end

        it "raises the quality by 1" do
          @subject.update_quality()
          expect(@items[0].quality).to eq 6
        end

        it "lowers the SellIn value by 1" do
          @subject.update_quality()
          expect(@items[0].sell_in).to eq 4
        end

        context "while quality is close to 50" do

          before :each do
            @items = [Item.new("Aged Brie", 5, 50)]
            @subject = GildedRose.new(@items)
          end

          it "doesn't raise the quality above 50" do
            @subject.update_quality()
            expect(@items[0].quality).to eq 50
          end

          it "lowers the SellIn value by 1" do
            @subject.update_quality()
            expect(@items[0].sell_in).to eq 4
          end

        end

      end

      context "if the item is Sulfuras, Hand of Ragnaros" do

        before :each do
          @items = [Item.new("Sulfuras, Hand of Ragnaros", 5, 20)]
          @subject = GildedRose.new(@items)
        end

        it "does not need to be sold" do
          @subject.update_quality()
          expect(@items[0].sell_in).to eq 5
        end

        it "does not decrease in quality" do
          @subject.update_quality()
          expect(@items[0].quality).to eq 20
        end

      end

      context "if the item is Backstage passes to a TAFKAL80ETC concert" do

        context "when there are more than 10 days to the concert" do

          before :each do
            @items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 20)]
            @subject = GildedRose.new(@items)
          end

          it "raises the quality by 1" do
            @subject.update_quality()
            expect(@items[0].quality).to eq 21
          end

          it "lowers the SellIn value by 1" do
            @subject.update_quality()
            expect(@items[0].sell_in).to eq 19
          end

          context "while quality is close to 50" do

            before :each do
              @items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 50)]
              @subject = GildedRose.new(@items)
            end

            it "doesn't raise the quality above 50" do
              @subject.update_quality()
              expect(@items[0].quality).to eq 50
            end

            it "lowers the SellIn value by 1" do
              @subject.update_quality()
              expect(@items[0].sell_in).to eq 4
            end

          end

        end

        context "when there are less than 10 days to the concert" do

          before :each do
            @items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 20)]
            @subject = GildedRose.new(@items)
          end

          it "raises the quality by 2" do
            @subject.update_quality()
            expect(@items[0].quality).to eq 22
          end

          it "lowers the SellIn value by 1" do
            @subject.update_quality()
            expect(@items[0].sell_in).to eq 8
          end

        end

        context "when there are less than 5 days to the concert" do

          before :each do
            @items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 20)]
            @subject = GildedRose.new(@items)
          end

          it "raises the quality by 3" do
            @subject.update_quality()
            expect(@items[0].quality).to eq 23
          end

          it "lowers the SellIn value by 1" do
            @subject.update_quality()
            expect(@items[0].sell_in).to eq 3
          end

        end

      end

    end

    context "while SellIn < 0" do

      before :each do
        @items = [Item.new("foo", -1, 4)]
        @subject = GildedRose.new(@items)
      end

      it "lowers the Quality value by 2" do
        @subject.update_quality()
        expect(@items[0].quality).to eq 2
      end

      it "lowers the SellIn value by 1" do
        @subject.update_quality()
        expect(@items[0].sell_in).to eq(-2)
      end

      context "if the item is Aged Brie" do

        before :each do
          @items = [Item.new("Aged Brie", -1, 5)]
          @subject = GildedRose.new(@items)
        end

        it "raises the quality by 2" do
          @subject.update_quality()
          expect(@items[0].quality).to eq 7
        end

        it "lowers the SellIn value by 1" do
          @subject.update_quality()
          expect(@items[0].sell_in).to eq(-2)
        end

        context "while quality is close to 50" do

          before :each do
            @items = [Item.new("Aged Brie", -5, 49)]
            @subject = GildedRose.new(@items)
          end

          it "doesn't raise the quality above 50" do
            @subject.update_quality()
            expect(@items[0].quality).to eq 50
          end

          it "lowers the SellIn value by 1" do
            @subject.update_quality()
            expect(@items[0].sell_in).to eq(-6)
          end

        end

      end

      context "if the item is Sulfuras, Hand of Ragnaros" do

        before :each do
          @items = [Item.new("Sulfuras, Hand of Ragnaros", -5, 20)]
          @subject = GildedRose.new(@items)
        end

        it "does not need to be sold" do
          @subject.update_quality()
          expect(@items[0].sell_in).to eq(-5)
        end

        it "does not decrease in quality" do
          @subject.update_quality()
          expect(@items[0].quality).to eq 20
        end

      end

      context "if the item is Backstage passes to a TAFKAL80ETC concert" do

        context "when there are more than 0 days to the concert" do

          before :each do
            @items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)]
            @subject = GildedRose.new(@items)
          end

          it "reduces the quality to 0" do
            @subject.update_quality()
            expect(@items[0].quality).to eq 0
          end

          it "lowers the SellIn value by 1" do
            @subject.update_quality()
            expect(@items[0].sell_in).to eq(-1)
          end

        end

      end

    end

    context "while quality is close to 0" do

      before :each do
        @items = [Item.new("foo", -1, 1)]
        @subject = GildedRose.new(@items)
      end

      it "doesn't lower the quality below 0" do
        @subject.update_quality()
        expect(@items[0].quality).to eq 0
      end

      it "lowers the SellIn value by 1" do
        @subject.update_quality()
        expect(@items[0].sell_in).to eq(-2)
      end

    end

  end

end
