class Repository < ApplicationRecord
  validates :name, presence: true
  validates :full_name, presence: true
  validates :description, presence: false
  validates :external_id, presence: true, uniqueness: { case_insensitive: true }
  validates :metadata, presence: true
end
