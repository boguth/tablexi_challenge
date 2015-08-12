class TextFile < ActiveRecord::Base
  attr_accessor :menu_items_array
  # You don't want to override the ActiveRecord::Base initialize methods, so I called the after_initalize to give me
  # Some variables to work with
  after_initialize do
    @menu_items_array =[]
    @price_array = []
    @matched_prices = []
    @call_count = 0
    @price_count_holder = []
    @combos_holder = []
  end

  # Our formatting checker that is used in the controller. Uses Regex to make sure the file is formatted like the
  # example file.
  def correct_formatting?(file)
    lines = []
    lines = file.split("\n")
    if lines[0] !~ /\$\d+.\d+/
      false
    end
    lines.delete_at(0)
    counter = lines.length
    lines.each do |line|
      if line.strip !~ /(\w+\s)*(\w+,)\$\d+.\d+/
        return false
      end
    end
   return true
  end

  # Here's what kicks it all off.
  def solve
    @menu_items_array = @menu_items_array.split("\n") # We make the variable live up to its name and split the string into an array.
    @menu_items_array.each do |line|
      @price_array << line.scan(/\d.+/)[0].to_f # Here, we take out each individual price, so we can work with them without having to
                                                # worry about the strings they're attached to.
    end
    @menu_items_array = @menu_items_array.drop(1) # We get rid of the target price from our menu items array. Note, this array now contains
                                                  # the menu items along with their prices.
    self.target_price = @price_array.delete_at(0).to_f # We get rid of the target price from our price array, which contains only the prices of the
                                                       # Menu items.
    subset_prices(@price_array, self.target_price)  # This is the algorithm that makes this program possible. It calculates all the possible prices that   could add up to the target price
    sort_dinner_combos # This starts the process of working through the different combinations of items we can order from the menu.
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

  def count_prices(prices) # This method returns a hash with the menu prices as keys and their occurrence as solutions as values.
    price_count = Hash.new 0
    prices.each do | price |
      if price_count[price.to_s]
        price_count[price.to_s] += 1 #This increments every time a price pops up as a solution.
      else
        price_count[price.to_s] = 1
      end
    end
    price_count
  end

  def sort_dinner_combos
    @matched_prices.each do |sub_price|
      @price_count_holder << count_prices(sub_price) # This makes a hash that sets a given price as a key and its occurrence in the solution set as its value.
    end

    @price_count_holder.each do |price_counts|
      @combos_holder << count_items(@menu_items_array, price_counts) # Here, we use the hash created above to match the cost of the items to the string they are associated with.
    end
    format_results # This formats the solution sets so that I can easily display them on the screen.
  end

  def count_items(menu, price_counts) # This matches each menu item with its occurrence as a solution.
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

  def format_results # Here we format the results so I can print them readably to the screen.
    @combos_holder.each do |combo|
      combo.map! do |item|
        if item.include?(",")
          item.gsub!(/\,.*/, "")
        else
          item
        end
      end
    end
    self.answer = @combos_holder
  end
end
