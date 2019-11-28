class AddDescriptonToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :description, :string
  end
end
