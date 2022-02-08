class Admin::OrderDetailsController < Admin::AdminController
  def index
    @order = Order.find_by id: params[:order_id]
    @order_details = @order.order_details
  end
end
