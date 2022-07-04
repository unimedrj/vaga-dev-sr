class Repository < ApplicationRecord
  LANGUAGES = JSON.load_file(Rails.root.join('spec', 'support', 'api.github.com', 'languages.json'))

  enum language: LANGUAGES.index_with(&:to_s), _prefix: true

  validates :language, presence: true
  validates :name, presence: true
  validates :full_name, presence: true
  validates :description, presence: false
  validates :external_id, presence: true, uniqueness: { case_insensitive: true }
  validates :metadata, presence: true
end
