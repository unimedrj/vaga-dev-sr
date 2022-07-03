require 'rails_helper'

RSpec.describe RepositoriesJob, type: :job do
  let(:language) { 'ruby' }

  it '.perform_later' do
    expect do
      described_class.perform_later(language)
    end.to have_enqueued_job(described_class).with(language).on_queue('default').at(:no_wait).exactly(:once)
  end

  describe '#perform' do
    let(:service) { instance_double(RepositoriesService) }

    it 'must call service' do
      expect(RepositoriesService).to receive(:new).with(language:) { service }

      expect(service).to receive(:call)

      subject.perform(language)
    end
  end
end
