
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AirQualityMetric, type: :model do

  describe 'Associations' do
    it { should belong_to(:location) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:aqi) }
    it { should validate_presence_of(:co) }
    it { should validate_presence_of(:no) }
    it { should validate_presence_of(:no2) }
    it { should validate_presence_of(:o3) }
    it { should validate_presence_of(:so2) }
    it { should validate_presence_of(:pm2_5) }
    it { should validate_presence_of(:pm10) }
    it { should validate_presence_of(:nh3) }
    it { should validate_presence_of(:dt) }
    it { should validate_presence_of(:location_id) }
  end
end
