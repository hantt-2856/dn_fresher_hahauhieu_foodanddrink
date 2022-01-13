require 'rails_helper'

RSpec.describe "Admin::OrderDetails", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/admin/order_details/index"
      expect(response).to have_http_status(:success)
    end
  end

end
