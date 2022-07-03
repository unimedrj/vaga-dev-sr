require 'rails_helper'

RSpec.describe RepositoriesService, type: :service do
  subject { described_class.new(language: 'ruby') }

  let(:language) { 'ruby' }
  let(:body_200) { File.read(Rails.root.join('spec', 'support', 'api.github.com', 'repositories.json')) }
  let(:body_422) { File.read(Rails.root.join('spec', 'support', 'api.github.com', 'validation_failed.json')) }

  describe '#language' do
    it { is_expected.to validate_presence_of(:language) }
  end

  describe '#call' do
    it 'must call!' do
      expect(subject).to receive(:call!)

      subject.call
    end

    it 'not must call!' do
      subject.language = nil

      expect(subject).not_to receive(:call!)

      subject.call
    end
  end

  describe '#call!' do
    it 'must successful' do
      expect(subject).to receive(:successful).with(body_200).and_call_original

      expect(subject.send(:call!)).to be_truthy
    end

    it 'must unsuccessful' do
      subject.language = nil

      expect(subject).to receive(:unsuccessful).with(body_422).and_call_original

      expect(subject.send(:call!)).to be_falsey
    end
  end

  it '#request' do
    response = subject.send(:request)

    expect(response.status).to eq(200)
    expect(response.body).to eq(body_200)
  end

  it '#url' do
    'https://api.github.com/search/repositories'
  end

  it '#params' do
    expect(subject.send(:params)).to eq(
      sort: 'stars',
      order: 'desc',
      per_page: 1,
      q: 'language:ruby'
    )
  end

  it '#successful' do
    result = JSON.parse(body_200)['items'].first
    attibutes = %i[language name full_name description external_id metadata]

    expect { subject.send(:successful, body_200) }.to change(Repository, :count).to(1)

    expect(Repository.first.as_json(only: attibutes)).to eq({
      language:,
      name: result['name'],
      full_name: result['full_name'],
      description: result['description'],
      external_id: result['id'].to_s,
      metadata: result
    }.as_json)
  end

  it '#unsuccessful' do
    subject.send(:unsuccessful, body_422)

    expect(subject.errors.details[:base]).to be_include(error: body_422)
  end
end
