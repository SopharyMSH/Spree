class Spree::SalePriceModel < ActiveRecord::Base
  has_many :variants
  has_many :sale_prices, -> { order(position: :asc) }, dependent: :destroy
  accepts_nested_attributes_for :sale_prices, allow_destroy: true,
    reject_if: proc { |sale_price|
      sale_price[:amount].blank?
    }
end