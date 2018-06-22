FactoryBot.define do
  factory :target_group do
    sequence(:name) { |n| "Target Group #{n}" }
    sequence(:external_id) { |n| "#{SecureRandom.hex(64)} + #{n}" }
    sequence(:secret_code) { |n| "#{SecureRandom.hex(64)} + #{n}" }
  end
end
