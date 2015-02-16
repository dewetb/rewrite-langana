class AddFirstLastNameToUsers < ActiveRecord::Migration
  def up
    remove_column :users, :name
    add_column    :users, :firstname, :string
    add_column    :users, :lastname, :string
  end

  def down
    remove_column :users, :firstname
    remove_column :users, :lastname
    add_column    :users, :name, :string
  end
end
