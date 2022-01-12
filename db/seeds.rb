Category.create!(name: "Example User",
                 parent_id: 1)
30.times do |n|
name = Faker::Name.name
  description = "example-#{n+1}@railstutorial.org"
  image = "banner.jpg"
  price = "#{n+1}"
  quantity = 1
  rating = 1
  category_id = 1

Product.create!(name: name,
                description: description,
                image: image,
                price: price,
                quantity: quantity,
                rating: rating,
                category_id: category_id)
end

# create_table "orders", charset: "utf8", force: :cascade do |t|
#   t.integer "status", default: 0
#   t.string "address"
#   t.string "phone"
#   t.float "total_price"
#   t.datetime "created_at", precision: 6, null: false
#   t.datetime "updated_at", precision: 6, null: false
#   t.bigint "user_id", null: false
#   t.index ["user_id"], name: "index_orders_on_user_id"
# end

# create_table "order_details", charset: "utf8", force: :cascade do |t|
#   t.integer "quantity"
#   t.float "price"
#   t.integer "product_id"
#   t.datetime "created_at", precision: 6, null: false
#   t.datetime "updated_at", precision: 6, null: false
#   t.bigint "order_id", null: false
#   t.index ["order_id"], name: "index_order_details_on_order_id"
# end

User.create(
  fullname: "Admin",
  email: "admin@gmail.com",
  role: 1,
  password: "123456",
  password_confirmation: "123456"
)

User.create!(
  fullname: "Ai Cũng được",
  email: "ai@gmail.com",
  password: "654321",
  password_confirmation: "654321")
  5.times do |n|
    fullname = Faker::Name.name
    email = "example-#{n+1}@gmail.com"
    password = "111111"
    password_confirmation = "111111"
    User.create!(
      fullname: fullname,
      email: email,
      role: 0,
      password: password,
      password_confirmation: password
    )
  end

5.times do |n|
  user_id = n + 1
  # address = Faker::Address.full_address
  address = "112 Nguyễn Phong Sắc"
  product_id = n + 1
  o = Order.new user_id: user_id, address: address, status: 1
  o.order_details.build product_id: product_id, quantity: 1, price: 1000 + n * 100
  o.save!
end
