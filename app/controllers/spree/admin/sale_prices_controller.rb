module Spree
 module Admin
   class SalePricesController < Spree::Admin::BaseController
     def destroy
       @sale_price = Spree::SalePrice.find(params[:id])
       @sale_price.destroy
       render nothing: true
     end
   end
 end
end