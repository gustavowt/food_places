# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NearestFoodPlacesController, type: :controller do
  describe 'GET #index' do
    it 'should return empty result when no position found' do
      VCR.use_cassette("empty_response") do
        get :index, params: { address: 'some place not found' }
      end

      expect(response).to have_http_status(:success)
      body = JSON.parse(response.body)

      expect(body).to eq({ "empty" => true })
    end

    it 'should return json food place data when found' do
      food_place1 = FoodPlace.create!(
        external_id: "1569152",
        applicant: "Datam SF LLC dba Anzu To You",
        facility_type: "truck",
        address: "2535 TAYLOR ST",
        status: "approved",
        fooditems: "Asian Fusion - Japanese Sandwiches/Sliders/Misubi",
        spherical_point: [-122.41594524663745, 37.805885350100986]
      )
      food_place2 = FoodPlace.create!(
        external_id: "1591825",
        applicant: "Cochinita",
        facility_type: "truck",
        address: "501 BEALE ST",
        status: "approved",
        fooditems: "Mexican Food: Yucatan Food: Street Food",
        spherical_point: [-122.38906620560476, 37.78623677446536]
      )

      VCR.use_cassette("union_square") do
        get :index, params: { address: 'union square', fooditem: 'Japanese', facility_type: 'truck' }
      end

      expect(response).to have_http_status(:success)
      body = JSON.parse(response.body)

      expect(body.size).to eq 1
      expect(body.first['external_id']).to eq food_place1.external_id
    end
  end
end
