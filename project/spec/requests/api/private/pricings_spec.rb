require 'rails_helper'

describe "Pricings", type: :request do
  context "for type times_a" do
    let(:panel_provider) { create(:panel_provider, code: "times_a") }
    let!(:country) { create(:country, panel_provider: panel_provider) }
    let(:target_group) { create(:target_group, panel_provider: panel_provider) }
    before :each do
      stub_request(:any, "http://time.com/")
        .to_return(body: file_fixture('example.html').read)
    end

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
        expect(JSON.parse(response.body)).to eq("price"=> 2.34)
      end

      it "returns status 200" do
        post(api_private_evaluate_target_path, params: params)
        expect(response.status).to eq(200)
      end
    end
  end

  context "for type 10_arrays" do
    let(:panel_provider) { create(:panel_provider, code: "10_arrays") }
    let!(:country) { create(:country, panel_provider: panel_provider) }
    let(:target_group) { create(:target_group, panel_provider: panel_provider) }
    before :each do
      stub_request(:any, "http://openlibrary.org/search.json?q=the+lord+of+the+rings")
        .to_return(body: file_fixture('example.json'))
    end

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
        expect(JSON.parse(response.body)).to eq("price"=> 3)
      end

      it "returns status 200" do
        post(api_private_evaluate_target_path, params: params)
        expect(response.status).to eq(200)
      end

      context "when response is timing out" do
        before :each do
          stub_request(:any, "http://openlibrary.org/search.json?q=the+lord+of+the+rings")
            .to_timeout
        end

        it "returns price" do
          post(api_private_evaluate_target_path, params: params)
          expect(JSON.parse(response.body)).to eq({"error"=>"Service timedout"})
        end
      end
    end
  end

  context "for type times_html" do
    let(:panel_provider) { create(:panel_provider, code: "times_html") }
    let!(:country) { create(:country, panel_provider: panel_provider) }
    let(:target_group) { create(:target_group, panel_provider: panel_provider) }
    before :each do
      stub_request(:any, "http://time.com/")
        .to_return(body: file_fixture('example.html').read)
    end

    context "when params are valid" do
      let!(:params) do
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
        expect(JSON.parse(response.body)).to eq("price"=> 11.29)
      end

      it "returns status 200" do
        post(api_private_evaluate_target_path, params: params)
        expect(response.status).to eq(200)
      end

      context "when response is timing out" do
        before :each do
          stub_request(:any, "http://time.com").to_timeout
        end

        it "returns timeout error" do
          post(api_private_evaluate_target_path, params: params)
          expect(JSON.parse(response.body)).to eq({"error"=>"Service timedout"})
        end
      end
    end
  end

  context "when location params are invalid" do
    let(:panel_provider) { create(:panel_provider) }
    let!(:country) { create(:country, panel_provider: panel_provider) }
    let(:target_group) { create(:target_group, panel_provider: panel_provider) }
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
