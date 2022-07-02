require 'rails_helper'

RSpec.describe Repository, type: :model do
  describe '#name' do
    it { is_expected.to validate_presence_of :name }
  end

  describe '#full_name' do
    it { is_expected.to validate_presence_of :full_name }
  end

  describe '#description' do
    it { is_expected.not_to validate_presence_of :description }
  end

  describe '#external_id' do
    it { is_expected.to validate_presence_of :external_id }

    it 'must be unique' do
      create :repository
      expect(subject).to validate_uniqueness_of(:external_id).case_insensitive
    end
  end

  describe '#metadata' do
    it { is_expected.to validate_presence_of :metadata }
  end
end
