require 'rails_helper'

RSpec.describe RepositoriesFilter, type: :filter do
  describe '#sort' do
    it { is_expected.to validate_presence_of :sort }
    it { is_expected.to validate_inclusion_of(:sort).in_array(%w[id language name external_id created_at updated_at]) }
  end

  describe '#order' do
    it { is_expected.to validate_presence_of :order }
    it { is_expected.to validate_inclusion_of(:order).in_array(%w[asc desc]) }
  end

  describe '#offset' do
    it { is_expected.to validate_presence_of :offset }
    it { is_expected.to validate_numericality_of(:offset).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#limit' do
    it { is_expected.to validate_presence_of :limit }

    it {
      expect(subject).to validate_numericality_of(:limit).only_integer.is_greater_than_or_equal_to(1).is_less_than_or_equal_to(100)
    }
  end

  describe '#search' do
    let!(:repository) { create(:repository) }
    let(:attributes) { { sort: 'id', order: 'asc', offset: 0, limit: 100 } }

    it 'must return any' do
      filter = described_class.new(attributes.merge(language: 'u', name: 'a'))

      expect(filter.search).to be_truthy

      expect(filter.results).to eq([repository])
      expect(filter.count).to eq(1)
      expect(filter.errors).to be_empty
    end

    it 'must return empty' do
      filter = described_class.new(attributes.merge(language: '%', name: '%'))

      expect(filter.search).to be_truthy

      expect(filter.results).to be_empty
      expect(filter.count).to be_zero
      expect(filter.errors).to be_empty
    end

    it 'must return nil' do
      filter = described_class.new

      expect(filter.search).to be_falsey

      expect(filter.results).to be_nil
      expect(filter.count).to be_nil
      expect(filter.errors).to be_any
    end
  end
end
