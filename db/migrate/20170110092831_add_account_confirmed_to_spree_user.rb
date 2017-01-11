class AddAccountConfirmedToSpreeUser < ActiveRecord::Migration
  def change
    add_column :spree_users, :account_confirmed, :boolean, default: false
  end
end
