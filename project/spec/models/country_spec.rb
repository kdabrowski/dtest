require "rails_helper"

describe Country, type: :model do
  it { should belong_to(:panel_provider) }
  it { should have_many(:location_groups) }
  it { should have_many(:locations).through(:location_groups) }
  it { should have_and_belong_to_many(:target_groups) }

  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:panel_provider) }

  it { should delegate_method(:code).to(:panel_provider).with_prefix }
end
