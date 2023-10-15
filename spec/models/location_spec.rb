# frozen_string_literal: true

require 'rails_helper'
require_relative '../../app/helpers/date_helper.rb'

RSpec.describe Location, type: :model do
  include DateHelper

  describe 'Associations' do
    it { should have_many(:air_quality_metrics) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:long) }
    it { should validate_presence_of(:state) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'Queries:' do
    let!(:location_kolkata) { Location.create({"lat": "22.5414185", "long": "88.35769124388872", "state": "West Bengal", "name": "Kolkata"}) }
    let!(:location_surat) { Location.create({"lat": "21.2094892", "long": "72.8317058", "state": "Gujarat", "name": "Surat"}) }
    let!(:air_quality_metric_1) { AirQualityMetric.new({"aqi": 5.0,"co": 1268.39,"no": 1.61,"no2": 25.71,"o3": 291.82,"so2": 93.46,"pm2_5": 296.46,"pm10": 337.09,"nh3": 3.17,"dt": '1697352684'}) }
    let!(:air_quality_metric_2) { AirQualityMetric.new({"aqi": 5.0,"co": 1188.28,"no": 0.74,"no2": 11.14,"o3": 263.21,"so2": 64.85,"pm2_5": 181.36,"pm10": 238.58,"nh3": 10.39,"dt": '1697352684'}) }
    let!(:air_quality_metric_3) { AirQualityMetric.new({"aqi": 4.0,"co": 347.14,"no": 0.54,"no2": 3.38,"o3": 144.48,"so2": 5.66,"pm2_5": 36.62,"pm10": 40.71,"nh3": 1.47,"dt": '1697352684' }) }

    context 'Query: average_aqi_per_location' do
      it 'Should calculate properly for particular location' do
        [air_quality_metric_1, air_quality_metric_2, air_quality_metric_3].each do |obj|
          obj.dt = convert_unix_timestamp_to_date_time(1697352684)
        end
        air_quality_metric_1.location = location_kolkata
        air_quality_metric_1.save
        air_quality_metric_2.location = location_kolkata
        air_quality_metric_2.save
        air_quality_metric_3.location = location_surat
        air_quality_metric_3.save

        data = Location.average_aqi_per_location('kolkata')

        expect(data.values.first.to_i).to match(5.0)
      end

      it 'Should include every location when no argument passed' do
        [air_quality_metric_1, air_quality_metric_2, air_quality_metric_3].each do |obj|
          obj.dt = convert_unix_timestamp_to_date_time(1697352684)
        end
        air_quality_metric_1.location = location_kolkata
        air_quality_metric_1.save
        air_quality_metric_2.location = location_kolkata
        air_quality_metric_2.save
        air_quality_metric_3.location = location_surat
        air_quality_metric_3.save

        data = Location.average_aqi_per_location()

        expect(data.keys.count).to match(2)
      end
    end

    context 'Query: average_aqi_per_state' do
      it 'Should calculate properly for particular state' do
        [air_quality_metric_1, air_quality_metric_2, air_quality_metric_3].each do |obj|
          obj.dt = convert_unix_timestamp_to_date_time(1697352684)
        end
        air_quality_metric_1.location = location_kolkata
        air_quality_metric_1.save
        air_quality_metric_2.location = location_kolkata
        air_quality_metric_2.save
        air_quality_metric_3.location = location_surat
        air_quality_metric_3.save

        data = Location.average_aqi_per_state(location_kolkata.state)

        expect(data.values.first.to_i).to match(5.0)
      end

      it 'Should include every state when no argument passed' do
        [air_quality_metric_1, air_quality_metric_2, air_quality_metric_3].each do |obj|
          obj.dt = convert_unix_timestamp_to_date_time(1697352684)
        end
        air_quality_metric_1.location = location_kolkata
        air_quality_metric_1.save
        air_quality_metric_2.location = location_kolkata
        air_quality_metric_2.save
        air_quality_metric_3.location = location_surat
        air_quality_metric_3.save

        data = Location.average_aqi_per_state()

        expect(data.keys.count).to match(2)
      end
    end

    context 'Query: average_aqi_per_month_per_location' do
      it 'Should include every location when no argument passed' do
        [air_quality_metric_1, air_quality_metric_2, air_quality_metric_3].each do |obj|
          obj.dt = convert_unix_timestamp_to_date_time(1697352684)
        end
        air_quality_metric_1.location = location_kolkata
        air_quality_metric_1.save
        air_quality_metric_2.location = location_kolkata
        air_quality_metric_2.save
        air_quality_metric_3.location = location_surat
        air_quality_metric_3.save

        data = Location.average_aqi_per_month_per_location()

        expect(data.keys.count).to match(2)
      end

      it 'Should calculate properly for particular city passed in argument' do
        [air_quality_metric_1, air_quality_metric_2, air_quality_metric_3].each do |obj|
          obj.dt = convert_unix_timestamp_to_date_time(1697352684)
        end
        air_quality_metric_1.location = location_kolkata
        air_quality_metric_1.save
        air_quality_metric_2.location = location_kolkata
        air_quality_metric_2.save
        air_quality_metric_3.location = location_surat
        air_quality_metric_3.save

        data = Location.average_aqi_per_month_per_location(city: location_kolkata.name)

        expect(data.keys.flatten[1]).to match(location_kolkata.name)
      end

      it 'Should be empty for end_date lesser then all metrics data' do
        [air_quality_metric_1, air_quality_metric_2, air_quality_metric_3].each do |obj|
          obj.dt = convert_unix_timestamp_to_date_time(1697352684)
        end
        air_quality_metric_1.location = location_kolkata
        air_quality_metric_1.save
        air_quality_metric_2.location = location_kolkata
        air_quality_metric_2.save
        air_quality_metric_3.location = location_surat
        air_quality_metric_3.save

        data = Location.average_aqi_per_month_per_location(end_date: 2.months.ago)

        expect(data.empty?).to match(true)
      end
    end
  end
end
