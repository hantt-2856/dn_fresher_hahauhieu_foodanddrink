require "rails_helper"
include SessionsHelper

RSpec.describe OrdersController, type: :controller do
  describe "GET/show" do
    let!(:user) {create(:user)}
    let!(:order) {create(:order, user_id: user.id)}
    let!(:order_detail_1) {create(:order_detail, order_id: order.id)}
    let!(:order_detail_2) {create(:order_detail, order_id: order.id)}
    let!(:order_detail_3) {create(:order_detail, order_id: order.id)}

    context "success when login as user" do
      before do
        log_in user
        get :show, params: {id: order.id}
      end
      it "assigns @order_details" do
        expect(assigns(:order_details)).to eq(order.order_details.sort_by_created_at)
      end

      it "render show view" do
        expect(response).to render_template(:show)
      end
    end

    context "fails when NOT login yet" do
      before do
        get :show, params: {id: order.id}
      end

      it "show message danger" do
        expect(flash[:danger]).to eq I18n.t("errors.not_login")
      end

      it "redirect to login_url" do
        expect(response).to redirect_to(login_url)
      end

      # let!(:origin_url){ double('request', original_url: order_url(order)) }
      # it "store original location" do
      #   controller.stub(:origin_url).and_return request
          
      #   get :show, params: {id: order.id}
 
      #   expect(session[:forwarding_url]).to eq(origin_url)
      # end

    end

    context "fails when params[:id] not found" do
      before do
        log_in user
        get :show, params: {id: -1}
      end

      it "show message warning" do
        expect(flash[:warning]).to eq I18n.t("error.not_found_order")
      end

      it "redirect_to root_path" do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET/new" do
    let!(:user) {create(:user)}
    before do
      log_in user
      get :new
    end

    context "show new view when order is valid"
      order
    end





  end




end


def check_invalid_order
  count = 0
  product_name = []
  session[:cart].each do |product_id, _quantity|
    product = Product.find_by id: product_id

    if product.nil?
      current_cart.delete product_id.to_s
      count += 1
    elsif current_cart[product_id] > product.quantity
      product_name << product_name.to_s
    end
  end

  invalid_message count, product_name
  @products = Product.by_ids load_products_in_cart
  @subtotal_in_cart = subtotal @products
end

def new
  if current_cart.empty?
    flash[:danger] = t ".please_buy_item"
    redirect_to root_path
  else
    @current_user
  end
end
      
before_action :logged_in_user
before_action :check_invalid_order, only: %i(new create)


      # def logged_in_user
      #   return if logged_in?
      
      #   store_location
      #   flash[:danger] = t "errors.not_login"
      #   redirect_to login_url
      # end
      
