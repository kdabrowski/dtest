require "rails_helper"

describe TargetGroup, type: :model do
  before do
    create(:target_group, panel_provider: create(:panel_provider), secret_code:"super_secret")
  end
  it { should belong_to(:panel_provider) }
  it { should belong_to(:parent).class_name("TargetGroup") }
  it { should have_many(:children).class_name("TargetGroup").with_foreign_key(:parent_id) }
  it { should validate_presence_of(:secret_code) }
  it { should validate_uniqueness_of(:secret_code) }
end
