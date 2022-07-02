FactoryBot.define do
  factory :repository do
    transient do
      result { JSON.load_file(Rails.root.join('spec', 'support', 'api.github.com', 'repositories.json')).first }
    end
    name { result['name'] }
    full_name { result['full_name'] }
    description { result['description'] }
    external_id { result['id'] }
    metadata { result }
  end
end
