class AddMobileToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :mobile, :string
  end
end
