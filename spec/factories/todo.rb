FactoryBot.define do
    factory :todo do
      name { 'Sample Todo' }
      done { false }
      user
    end
  end