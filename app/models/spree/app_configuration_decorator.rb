Spree::AppConfiguration.class_eval do
 preference :use_master_variant_sale_pricing, :boolean, default: false
 preference :sale_pricing_role, :string, default: 'wholesale'
end