require 'rails_helper'

RSpec.describe 'repositories/show.json', type: :view do
  let(:repository) { create(:repository) }

  before { assign(:repository, repository) }

  it 'renders repository attributes' do
    render

    expect(JSON.parse(rendered)).to eq({
      repository: {
        id: repository.id,
        language: repository.language,
        name: repository.name,
        full_name: repository.full_name,
        description: repository.description,
        external_id: repository.external_id,
        metadata: repository.metadata,
        created_at: repository.created_at,
        updated_at: repository.updated_at
      }
    }.as_json)
  end
end
