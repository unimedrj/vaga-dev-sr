RSpec.configure do |config|
  config.before do
    stub_request(:get, %r{https://api.github.com/search/repositories(.*)})
      .with(
        headers: {
          'Accept' => 'application/vnd.github.v3+json',
          'Authorization' => "token #{ENV['GITHUB_PERSONAL_ACCESS_TOKEN']}"
        }
      )
      .to_return(
        lambda { |request|
          query = Rack::Utils.parse_nested_query(request.uri.query).symbolize_keys
          query_expected = { sort: query[:sort], order: query[:order], per_page: query[:per_page], q: query[:q] }

          if query_expected == query && query[:q] != 'language:'
            { status: 200, body: File.read(Rails.root.join('spec', 'support', 'api.github.com', 'repositories.json')) }
          else
            { status: 422, body: File.read(Rails.root.join('spec', 'support', 'api.github.com', 'validation_failed.json')) }
          end
        }
      )
  end
end
