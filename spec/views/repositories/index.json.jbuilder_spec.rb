require 'rails_helper'

RSpec.describe 'repositories/index.json', type: :view do
  let(:repository) { create(:repository) }
  let(:filter) { instance_double(RepositoriesFilter, results: [repository], count: 1) }

  before { assign(:filter, filter) }

  it 'renders repository attributes' do
    render

    expect(JSON.parse(rendered)).to eq({
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
