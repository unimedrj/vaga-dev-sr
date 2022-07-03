require 'rails_helper'

RSpec.describe 'repositories/index', type: :view do
  it 'renders a list' do
    render

    expect(rendered).to match('repository.id')
    expect(rendered).to match('repository.language')
    expect(rendered).to match('repository.name')
    expect(rendered).to match('repository.external_id')
    expect(rendered).to match('repository.created_at')
    expect(rendered).to match('repository.updated_at')
    expect(rendered).to match('repository.path_to.show')
  end
end
