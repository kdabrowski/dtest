RSpec.shared_examples "a target group request" do |path_helper|
  describe "Target Groups", type: :request do
    let(:panel_provider) { create(:panel_provider) }
    let!(:country) { create(:country, panel_provider: panel_provider) }
    let!(:target_group_root_1) { create(:target_group, panel_provider: panel_provider) }
    let!(:target_group_root_2) { create(:target_group, panel_provider: panel_provider) }
    let!(:target_group_child_3)  { create(:target_group, panel_provider: panel_provider, parent: target_group_root_1)  }

    it "returns root target groups" do
      country.target_groups << [target_group_root_1, target_group_root_2, target_group_child_3]
      get "/api/#{path_helper.to_s}/target_groups/#{country.code}"
      expect(JSON.parse(response.body).values.first)
        .to eq([{"name"=>target_group_root_1.name}, {"name"=>target_group_root_2.name}])
    end
  end
end
