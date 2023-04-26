FactoryBot.define do
  factory :list_user do
    list { create(:list) }
    user { create(:user) }
  end
end
