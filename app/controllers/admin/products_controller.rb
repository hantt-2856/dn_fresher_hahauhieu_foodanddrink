class Admin::ProductsController < Admin::AdminController
  def index
    @pagy, @products = pagy Product.newest, items: Settings.per_page_10
  end
end
