class CreateSpreeSalePriceModels < ActiveRecord::Migration
  def change
    create_table :spree_sale_price_models do |t|
      t.string :name
      t.timestamps
    end

    create_table :spree_variants_sale_price_models do |t|
      t.belongs_to :sale_price_model
      t.belongs_to :variant
    end

    add_reference :spree_sale_prices, :sale_price_model

    add_index :spree_variants_sale_price_models, :sale_price_model_id, name: 'sale_price_model_id'
    add_index :spree_variants_sale_price_models, :variant_id, name: 'variant_id'
  end
end
