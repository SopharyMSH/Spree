Spree::Admin::VariantsController.class_eval do

 def edit
   @variant.sale_prices.build if @variant.sale_prices.empty?
   super
 end

 def sale_prices
   @product = @variant.product
   @variant.sale_prices.build if @variant.sale_prices.empty?
 end

 private

 # this loads the variant for the master variant sale price editing
 def load_resource_instance
   parent

   if new_actions.include?(params[:action].to_sym)
     build_resource
   elsif params[:id]
     Spree::Variant.find(params[:id])
   end
 end

 def location_after_save
   if @product.master.id == @variant.id && params[:variant].key?(:sale_prices_attributes)
     return sale_prices_admin_product_variant_url(@product, @variant)
   end
   super
 end
end