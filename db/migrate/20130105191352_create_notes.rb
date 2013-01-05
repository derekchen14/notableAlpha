class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :content
      t.integer :user_id
      t.integer :item_id
      t.string :format

      t.timestamps
    end
    add_index :notes, [:user_id, :created_at]
    add_index :notes, :item_id
  end
end
