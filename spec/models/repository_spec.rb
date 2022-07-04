require 'rails_helper'

RSpec.describe Repository, type: :model do
  describe '.enum' do
    it {
      expect(subject).to define_enum_for(:language).with_values(
        described_class::LANGUAGES.index_with(&:to_s)
      ).with_prefix.backed_by_column_of_type(:string)
    }
  end

  describe '#language' do
    it { is_expected.to validate_presence_of :language }
  end

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
