require 'rails_helper'

describe "Pricings", type: :request do
  let(:panel_provider) { create(:panel_provider) }
  let(:country) { create(:country, panel_provider: panel_provider) }
  let(:target_group) { create(:target_group, panel_provider: panel_provider) }

  context "when params are valid" do
    let(:params) do
      {
        country_code: country.code,
        target_group_id: target_group.id,
        locations: [
          {id: 123, panel_size: 223},
          {id: 123, panel_size: 211},
          {id: 123, panel_size: 201}
        ]
      }
    end

    it "returns price" do
      post(api_private_evaluate_target_path, params: params)
      expect(JSON.parse(response.body)).to eq("price"=> 0.9)
    end

    it "returns status 200" do
      post(api_private_evaluate_target_path, params: params)
      expect(response.status).to eq(200)
    end
  end

  context "when location params are invalid" do
    let(:params) do
      {
        country_code: country.code,
        target_group_id: target_group.id,
        locations: [
          {id: 123},
        ]
      }
    end

    it "returns error message" do
      post(api_private_evaluate_target_path, params: params)
      expect(JSON.parse(response.body)).to eq("message"=>"Invalid params")
    end

    it "returns status 422" do
      post(api_private_evaluate_target_path, params: params)
      expect(response.status).to eq(422)
    end
  end
end
