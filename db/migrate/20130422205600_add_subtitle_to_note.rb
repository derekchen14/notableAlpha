class AddSubtitleToNote < ActiveRecord::Migration
  def change
    add_column :notes, :subtitle, :string
  end
end
