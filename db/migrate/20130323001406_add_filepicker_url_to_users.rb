class AddFilepickerUrlToUsers < ActiveRecord::Migration
  def up
      add_column :users, :filepicker_url, :string
  end

  def down
      remove_column :users, :filepicker_url
  end    
end
