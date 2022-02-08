class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def index
    @product = @q.result
    if @product.empty?
      flash[:danger] = t "errors.not_found_product"
      redirect_to products_path
    else
      @pagy, @products = pagy @product, items: Settings.number.digit_12
      render :index
    end
  end

  def show; end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:danger] = t "errors.not_found_product"
    redirect_to root_path
  end
end
