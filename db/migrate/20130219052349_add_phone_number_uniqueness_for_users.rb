class AddPhoneNumberUniquenessForUsers < ActiveRecord::Migration
  def change
    remove_column :users, :sendhub_id
    remove_column :users, :phone_number
    add_column :users, :sendhub_id, :integer
    add_column :users, :phone_number, :string
    execute "create unique index phone_number_index on users(phone_number)"
  end
end
