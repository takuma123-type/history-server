FactoryBot.define do
  factory :user do
    association :authentication, factory: :authentication
    name { Faker::Name.name }

    # 特定の email/password を直接指定できるように
    transient do
      email { 'default@example.com' }
      password { 'password' }
    end

    after(:create) do |user, evaluator|
      user.authentication.update(login_id: evaluator.email, password_digest: BCrypt::Password.create(evaluator.password))
    end
  end
end
