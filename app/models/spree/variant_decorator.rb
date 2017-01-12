Spree::Variant.class_eval do
  has_and_belongs_to_many :sale_price_models
  has_many :sale_prices, -> { order(position: :asc) }, dependent: :destroy
  has_many :model_sale_prices, -> { order(position: :asc) }, class_name: 'Spree::SalePrice', through: :sale_price_models, source: :sale_prices
  accepts_nested_attributes_for :sale_prices, allow_destroy: true,
    reject_if: proc { |sale_price|
      sale_price[:amount].blank?
    }

  def join_sale_prices(user = nil)
    table = Spree::SalePrice.arel_table

    if user
      Spree::SalePrice.where(
        (table[:variant_id].eq(id)
          .or(table[:sale_price_model_id].in(sale_price_models.ids)))
          .and(table[:role_id].eq(user.resolve_role))
        )
        .order(position: :asc)
    else
      Spree::SalePrice.where(
        (table[:variant_id]
          .eq(id)
          .or(table[:sale_price_model_id].in(sale_price_models.ids)))
          .and(table[:role_id].eq(nil))
        ).order(position: :asc)
    end
  end

  # calculates the price based on quantity
  def sale_price(quantity, user = nil)
    compute_sale_price_quantities :sale_price, price, quantity, user
  end

  # return percent of earning
  def sale_price_earning_percent(quantity, user = nil)
    compute_sale_price_quantities :sale_price_earning_percent, 0, quantity, user
  end

  # return amount of earning
  def sale_price_earning_amount(quantity, user = nil)
    compute_sale_price_quantities :sale_price_earning_amount, 0, quantity, user
  end

  protected

  def use_master_variant_sale_pricing?
    Spree::Config.use_master_variant_sale_pricing && !(product.master.join_sale_prices.count == 0)
  end

  def compute_sale_price_quantities(type, default_price, quantity, user)
    sale_prices = join_sale_prices user
    if sale_prices.count == 0
      if use_master_variant_sale_pricing?
        product.master.send(type, quantity, user)
      else
        return default_price
      end
    else
      sale_prices.each do |sale_price|
        if sale_price.include?(quantity)
          return send "compute_#{type}".to_sym, sale_price
        end
      end

      # No price ranges matched.
      default_price
    end
  end

  def compute_sale_price(sale_price)
    case sale_price.discount_type
    when 'price'
      return sale_price.amount
    when 'dollar'
      return price - sale_price.amount
    when 'percent'
      return price * (1 - sale_price.amount)
    end
  end

  def compute_sale_price_earning_percent(sale_price)
    case sale_price.discount_type
    when 'price'
      diff = price - sale_price.amount
      return (diff * 100 / price).round
    when 'dollar'
      return (sale_price.amount * 100 / price).round
    when 'percent'
      return (sale_price.amount * 100).round
    end
  end

  def compute_sale_price_earning_amount(sale_price)
    case sale_price.discount_type
    when 'price'
      return price - sale_price.amount
    when 'dollar'
      return sale_price.amount
    when 'percent'
      return price - (price * (1 - sale_price.amount))
    end
  end
end