FactoryBot.define do
    factory :item do
      name { 'Sample Item' }
      price { 9.99 }
      association :todo, factory: :todo
    end
  end