class CreateTextFiles < ActiveRecord::Migration
  def change
    create_table :text_files do |t|
      t.float :target_price
      t.string :answer, array: true, default: []

      t.timestamps null: false
    end
  end
end
