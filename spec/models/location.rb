# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Location, type: :model do
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
end
