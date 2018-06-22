RSpec.shared_examples "a locations request" do |path_helper|
  describe "Locations shared", type: :request do
    let(:panel_provider) { create(:panel_provider) }
    let!(:country) { create(:country, panel_provider: panel_provider) }
    let!(:location_1) { create(:location, name: "New York") }
    let!(:location_2) { create(:location, name: "San Francisco") }
    let!(:location_group) do
      create(:location_group, country: country, panel_provider: panel_provider)
    end

    it "returns locations by id" do
      location_group.locations << [location_1, location_2]
      get "/api/#{path_helper.to_s}/locations/#{country.code}"
      expect(JSON.parse(response.body).values.first).to eq([{"name"=>"New York"}, {"name"=>"San Francisco"}])
    end
  end

  context "when the country code is invalid" do
    it "returns error message" do
      get "/api/#{path_helper.to_s}/locations/fake_code"
      expect(JSON.parse(response.body)).to eq("error"=>"Resource not found")
    end

    it "returns 404 status code" do
      get "/api/#{path_helper.to_s}/locations/fake_code"
      expect(response.code).to eq("404")
    end
  end
end
