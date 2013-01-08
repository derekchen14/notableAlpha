class AddDefaultToNotes < ActiveRecord::Migration
  def change
  	change_column :notes, :format, :string, default: 'topdown'
  end
end
