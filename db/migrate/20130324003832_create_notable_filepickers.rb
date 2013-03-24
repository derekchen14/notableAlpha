class CreateNotableFilepickers < ActiveRecord::Migration
  def change
    create_table :notable_filepickers do |t|
      t.string :url
      t.integer :note_id

      t.timestamps
    end
  end
end
