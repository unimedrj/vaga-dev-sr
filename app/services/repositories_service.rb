class RepositoriesService
  include ActiveModel::Model

  attr_accessor :language

  validates :language, presence: true

  def call
    call! if valid?
  end

  private

  def call!
    response = request

    if response.status == 200
      successful response.body
      true
    else
      unsuccessful response.body
      false
    end
  end

  def request
    Faraday.get url do |request|
      request.headers.merge!(
        accept: 'application/vnd.github.v3+json',
        authorization: "token #{ENV['GITHUB_PERSONAL_ACCESS_TOKEN']}"
      )
      request.params = params
    end
  end

  def url
    'https://api.github.com/search/repositories'
  end

  def params
    {
      sort: 'stars',
      order: 'desc',
      per_page: 1,
      q: "language:#{language}"
    }
  end

  def successful(body)
    if (result = JSON.parse(body)['items'].first).present?
      Repository.create(
        language:,
        name: result['name'],
        full_name: result['full_name'],
        description: result['description'],
        external_id: result['id'].to_s,
        metadata: result
      )
    end
  end

  def unsuccessful(body)
    errors.add :base, body
  end
end
