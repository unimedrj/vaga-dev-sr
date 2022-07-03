require 'rails_helper'

RSpec.describe '/repositories', type: :request do
  describe 'GET /index' do
    context 'renders a successful response' do
      it 'html' do
        get repositories_url

        expect(response).to be_successful
      end

      it 'json' do
        get repositories_url(sort: 'id', order: 'asc', offset: 0, limit: 100, name: 'Name', format: :json)

        expect(response).to be_successful
      end
    end

    context 'renders a unsuccessful response' do
      it 'json' do
        get repositories_url(format: :json)

        expect(response).to be_unprocessable
      end
    end
  end

  describe 'GET /show' do
    context 'renders a successful response' do
      let(:repository) { create(:repository) }

      it 'html' do
        get repository_url(id: repository.id)

        expect(response).to be_successful
      end

      it 'json' do
        get repository_url(id: repository.id, format: :json)

        expect(response).to be_successful
      end
    end

    context 'renders a unsuccessful response' do
      it 'html' do
        get repository_url(id: 0)

        expect(response).to be_not_found
      end

      it 'json' do
        get repository_url(id: 0, format: :json)

        expect(response).to be_not_found
      end
    end
  end

  describe 'POST /create' do
    context 'renders a successful response' do
      it 'json' do
        post repositories_url(format: :json)

        expect(response).to be_successful
      end
    end

    context 'renders a unsuccessful response' do
      it 'html' do
        post repositories_url

        expect(response).to be_not_found
      end
    end
  end
end
