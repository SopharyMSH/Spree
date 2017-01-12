class AddRoleToSalePrice < ActiveRecord::Migration
  def change
    add_column :spree_sale_prices, :role_id, :integer
  end
end
