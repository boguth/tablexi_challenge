class CreateTextFiles < ActiveRecord::Migration
  def change
    create_table :text_files do |t|
      t.float :target
      t.string :answer, array: true, default: []
      t.string :lines

      t.timestamps null: false
    end
  end
end
