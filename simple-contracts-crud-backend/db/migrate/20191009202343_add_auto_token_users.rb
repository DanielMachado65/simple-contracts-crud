class AddAutoTokenUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :auth_token, :string
  end

  def down
    remove_column :users, :auth_token, :string
  end
end
