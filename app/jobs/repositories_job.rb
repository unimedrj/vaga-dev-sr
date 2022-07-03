class RepositoriesJob < ApplicationJob
  queue_as :default

  def perform(language)
    RepositoriesService.new(language:).call
  end
end
