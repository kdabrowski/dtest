require "rails_helper"

describe LocationGroup, type: :model do
  it { should have_and_belong_to_many(:locations) }
  it { should belong_to(:panel_provider) }
  it { should belong_to(:country) }
end
