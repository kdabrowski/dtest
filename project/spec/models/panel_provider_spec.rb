require "rails_helper"

describe PanelProvider, type: :model do
  it { should have_many(:countries) }
  it { should validate_presence_of(:code) }
end
