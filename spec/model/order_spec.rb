require "rails_helper"
require "support/factory_bot"

RSpec.describe Order, type: :model do
  subject {create(:order)}

  describe "be valid" do
    it "has a valid factory" do
      expect(subject).to be_valid
    end
  end

  describe "enums" do
    it "define status as an enum" do
      should define_enum_for(:status)
    end
  end

  describe "Validates" do
    it {is_expected.to validate_presence_of(:address)}
    it {is_expected.to validate_presence_of(:phone)}
  end

  describe "Associations" do
    it {is_expected.to have_many(:order_details).dependent(:destroy)}
    it {is_expected.to belong_to(:user)}
  end

  describe "Delegate" do
    it {should delegate_method(:fullname).to(:user).with_prefix}
    it {should delegate_method(:email).to(:user).with_prefix}
  end

  describe "#sort_orders" do
    it "order by status asc and created_at desc" do
      order_1 = create(:order, status: 3)
      order_2 = create(:order, status: 0)
      expect(Order.sort_orders).to eq([order_2, order_1])
    end
  end

  describe "#update_quantity_product" do
    let(:order_detail_1) {create(:order_detail, order_id: subject.id)}
    let(:order_detail_2) {create(:order_detail, order_id: subject.id)}

    it "increase product quantity if status change to rejected" do
      expect(subject.update!(status: Order.statuses[:rejected])).to be true
      subject.update_quantity_product
      subject.order_details.each do |item|
        expect(item.product.quantity).to eq(52)
      end
    end

    it "NOT change product quantity if status NOT be rejected" do
      expect(subject.update!(status: Order.statuses[:accept])).to be true
      subject.update_quantity_product
      subject.order_details.each do |item|
        expect(item.product.quantity).to eq(50)
      end
    end
  end
end
