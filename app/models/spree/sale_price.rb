class Spree::SalePrice < ActiveRecord::Base
  belongs_to :variant, touch: true
  belongs_to :sale_price_model, touch: true
  belongs_to :spree_role, class_name: 'Spree::Role', foreign_key: 'role_id'
  acts_as_list scope: [:variant_id, :sale_price_model_id]

  validates :amount, presence: true

end
