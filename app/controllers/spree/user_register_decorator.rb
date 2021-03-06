Spree::UserRegistrationsController.class_eval do
 def create
   @user = build_resource(spree_user_params)
   resource.billing_address = resource.set_billing_address(@user)
   resource.shipping_address = resource.set_shipping_address(@user)
   resource_saved = resource.save
   yield resource if block_given?
   if resource_saved
     if resource.active_for_authentication?
       set_flash_message :notice, :signed_up
       sign_up(resource_name, resource)
       session[:spree_user_signup] = true
       respond_with resource, location: after_sign_up_path_for(resource)
     else
       set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}"
       expire_data_after_sign_in!
       respond_with resource, location: after_inactive_sign_up_path_for(resource)
     end
   else
     clean_up_passwords(resource)
     render :new
   end
 end
end
