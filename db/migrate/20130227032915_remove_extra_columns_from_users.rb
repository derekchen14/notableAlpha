class RemoveExtraColumnsFromUsers < ActiveRecord::Migration
  def up
    drop_table :users

    create_table :users

    add_column :users, :username, :string
    add_column :users, :email, :string
    add_column :users, :admin, :boolean, :default => false
    add_column :users, :sendhub_id, :integer
    add_column :users, :phone_number, :string
    
    add_index "users", ["phone_number"], :name => "phone_number_index", :unique => true
    add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  
  end

  def down
    create_table :users
    
    add_column :users, :username, :string
    add_column :users, :password, :string
    add_column :users, :email, :string
    add_column :users, :admin, :boolean, :default => false
    add_column :users, :sendhub_id, :integer
    add_column :users, :phone_number, :string
    add_column :users, :password_digest, :string
    add_column :users, :remember_token

    add_index "users", ["email"], :name => "index_users_on_email", :unique => true
    add_index "users", ["phone_number"], :name => "phone_number_index", :unique => true
    add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  end
end
