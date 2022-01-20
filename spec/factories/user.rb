FactoryBot.define do
  factory :user, class: "User" do
    fullname {Faker::Name.name}
    email {Faker::Internet.email}
    password {"111111"}
    password_confirmation {"111111"}
    role {0}
    address {Faker::Address.full_address}
  end
end
