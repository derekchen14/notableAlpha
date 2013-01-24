class AddSendHubIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sendhub_id, :integer
  end
end
