# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodPlace, type: :model do
  context 'Validations' do
    it { is_expected.to validate_presence_of(:geo_point) }
    it { is_expected.to validate_presence_of(:facility_type) }
    it { is_expected.to validate_presence_of(:status) }
  end
end
