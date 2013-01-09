class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :variable
      t.string :data
      t.integer :note_id
      t.integer :user_id

      t.timestamps
    end
  end
end
