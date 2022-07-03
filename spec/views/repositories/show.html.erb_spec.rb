require 'rails_helper'

RSpec.describe 'repositories/show', type: :view do
  it 'renders repository attributes' do
    render

    expect(rendered).to match('repository.id')
    expect(rendered).to match('repository.language')
    expect(rendered).to match('repository.name')
    expect(rendered).to match('repository.full_name')
    expect(rendered).to match('repository.description')
    expect(rendered).to match('repository.external_id')
    expect(rendered).to match('repository.metadata')
    expect(rendered).to match('repository.created_at')
    expect(rendered).to match('repository.updated_at')
  end
end
