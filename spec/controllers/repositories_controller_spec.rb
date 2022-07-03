require 'rails_helper'

RSpec.describe RepositoriesController, type: :controller do
  describe '.before_action' do
    it { is_expected.to use_before_action(:set_repository) }
  end

  describe 'GET #index' do
    it 'respond .html' do
      get :index

      expect(response).to be_ok
    end

    it 'respond .csv' do
      get :index, format: :csv

      expect(response).to be_not_found
    end

    it 'respond .json' do
      repository = create(:repository)

      get :index, params: { sort: 'id', order: 'asc', offset: 0, limit: 100 }, format: :json

      expect(response).to be_ok
      expect(JSON.parse(response.body)).to eq({
        repositories: [{
          id: repository.id,
          language: repository.language,
          name: repository.name,
          external_id: repository.external_id,
          created_at: repository.created_at,
          updated_at: repository.updated_at,
          path_to: {
            show: repository_path(repository)
          }
        }],
        count: 1
      }.as_json)
    end
  end

  describe 'GET #show' do
    let(:repository) { create(:repository) }

    it 'respond .html' do
      get :show, params: { id: repository.id }

      expect(response).to be_ok
    end

    it 'respond .csv' do
      get :show, params: { id: repository.id }, format: :csv

      expect(response).to be_not_found
    end

    it 'respond .json' do
      get :show, params: { id: repository.id }, format: :json

      expect(response).to be_ok
      expect(JSON.parse(response.body)).to eq({
        repository: {
          id: repository.id,
          language: repository.language,
          name: repository.name,
          full_name: repository.full_name,
          description: repository.description,
          external_id: repository.external_id,
          metadata: repository.metadata,
          created_at: repository.created_at.in_time_zone,
          updated_at: repository.updated_at.in_time_zone
        }
      }.as_json)
    end
  end

  describe 'POST #create' do
    it 'respond .html' do
      post :create

      expect(response).to be_not_found
    end

    it 'must be ok' do
      expect do
        post :create, format: :json
      end.to have_enqueued_job(RepositoriesJob).with { |language|
        expect(Repository::LANGUAGES).to be_include(language)
      }.on_queue('default').at(:no_wait).exactly(5)

      expect(response).to be_ok
      expect(JSON.parse(response.body)).to eq({
        languages: assigns(:languages)
      }.as_json)
    end
  end

  it '#set_repository' do
    repository = create(:repository)
    controller.params[:id] = repository.id

    controller.send(:set_repository)

    expect(assigns(:repository)).to eq(repository)
  end

  it '#filter_params' do
    params = { sort: '', order: '', offset: '', limit: '', language: '', name: '' }

    controller.params = params

    expect(controller.send(:filter_params).as_json).to eq(params.as_json)
  end
end
