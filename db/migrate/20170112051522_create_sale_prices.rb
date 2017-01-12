class CreateSalePrices < ActiveRecord::Migration
  def self.up
     create_table :spree_sale_prices do |t|
       t.references :variant
       t.string :display
       t.decimal :amount, precision: 8, scale: 2
       t.integer :position
       t.timestamps
     end
   end

   def self.down
     drop_table :spree_sale_prices
   end
end
