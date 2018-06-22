FactoryBot.define do
  factory :location do
    name "Location 1"
    sequence(:external_id) { |n| "#{SecureRandom.hex(64)} + #{n}" }
    sequence(:secret_code) { |n| "#{SecureRandom.hex(64)} + #{n}" }
  end
end
