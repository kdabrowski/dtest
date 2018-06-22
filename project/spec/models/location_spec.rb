require "rails_helper"

describe Location, type: :model do
  before { create(:location, name: "Sosnowiec") }

  it { should have_and_belong_to_many(:location_groups) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:external_id) }
  it { should validate_presence_of(:secret_code) }
  it { should validate_uniqueness_of(:external_id) }

end
