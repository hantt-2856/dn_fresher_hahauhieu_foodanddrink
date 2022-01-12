class Admin::OrdersController < Admin::BaseController
  def index
    @pagy, @orders = pagy(Order.sort_by_create_at, items: Settings.per_page_10)
  end
end
