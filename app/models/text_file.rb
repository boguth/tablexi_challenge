class TextFile < ActiveRecord::Base
  attr_accessor :menu_items_array, :target


  after_initialize do
    @menu_items_array =[]
    @target = 0
    @price_array = []
    @matched_prices = []
    @call_count = 0
    @price_count_holder = []
    @combos_holder = []
  end

  def solve
    @menu_items_array = @menu_items_array.split("\n")
    @menu_items_array.each do |line|
      @price_array << line.scan(/\d.+/)[0].to_f
    end
    @menu_items_array = @menu_items_array.drop(1)
    @target = @price_array.delete_at(0)
    subset_prices(@price_array, @target.to_f)
    sort_dinner_combos
  end

  private

  def subset_prices(prices, target, partial=[])
    current_total = partial.inject(:+)
    if current_total == target
      @matched_prices << partial
    end
    if current_total == nil
      current_total = 0
    end
    if current_total >= target
      return
    end
    prices.each_with_index do |price, index|
      remaining = prices.drop(index)
      subset_prices(remaining, target, partial + [price])
    end
  end

  def count_prices(prices)
    price_count = Hash.new 0
    prices.each do | price |
      if price_count[price.to_s]
        price_count[price.to_s] += 1
      else
        price_count[price.to_s] = 1
      end
    end
    price_count
  end

  def sort_dinner_combos
    @matched_prices.each do |sub_price|
      @price_count_holder << count_prices(sub_price)
    end

    @price_count_holder.each do |price_counts|
      @combos_holder << count_items(@menu_items_array, price_counts)
    end
    format_results
  end

  def count_items(menu, price_counts)
    current_combo = []
    price_counts.each do |price, count|
      menu.each do |menu_item|
        if menu_item.include?(price)
          current_combo << count.to_s
          current_combo << menu_item
        end
      end
    end
    current_combo
  end

  def format_results
    @combos_holder.each do |combo|
      combo.map! do |item|
        if item.include?(",")
          item.gsub!(/\,.*/, "")
        else
          item
        end
      end
    end
    @combos_holder
  end
end
