module SessionsHelper
  def add_product_to_cart product_id, quantity
    quantity_card = current_cart[product_id] || 0
    quantity_card += quantity.to_i
    current_cart[product_id] = quantity_card.to_i
  end

  def current_user? user
    user == current_user
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def current_cart
    @current_cart ||= session[:cart]
  end

  def subtotal products
    products.reduce(0) do |sum, item|
      sum + total_item(item)
    end
  end

  def load_products_in_cart
    current_cart.keys
  end

  def redirect_back_or default
    redirect_to(session[:forwarding_url] || default)
    session.delete :forwarding_url
  end

  def total_item product
    (product.price * current_cart[product.id.to_s].to_i).round(2)
  end

  def handle_price product
    product.price.round(2)
  end
end
