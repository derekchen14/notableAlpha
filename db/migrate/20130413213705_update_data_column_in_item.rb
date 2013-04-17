class UpdateDataColumnInItem < ActiveRecord::Migration
  def up
    remove_column :items, :data
    add_column :items, :data, :binary
  end

  def down
    remove_column :items, :data
    add_column :items, :data, :string
  end
end
