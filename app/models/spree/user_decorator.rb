Spree::User.class_eval do
  has_many :spree_addresses, class_name: Spree::Address
  accepts_nested_attributes_for :spree_addresses

  def active_for_authentication?
    super && account_confirmed?
  end
  def set_shipping_address(spree_user)
   shipping_address = initialize_spree_address(spree_user)
   shipping_address
 end

 def set_billing_address(spree_user)
   billing_address = initialize_spree_address(spree_user)
   billing_address
 end

 def initialize_spree_address(spree_user)
   raw_info = spree_user.spree_addresses.last
   address = Spree::Address.create(
   {
       firstname:         raw_info.firstname,
       lastname:          raw_info.lastname,
       address1:          raw_info.address1,
       address2:          raw_info.address2,
       city:              raw_info.city,
       zipcode:           raw_info.zipcode,
       phone:             raw_info.phone,
       state_name:        raw_info.state_name,
       alternative_phone: nil,
       company:           nil,
       state_id:          raw_info.state_id,
       country_id:        raw_info.country_id
   })

   address
 end
end
