json.repositories @filter.results do |repository|
  json.extract! repository, :id, :language, :name, :external_id, :created_at, :updated_at

  json.path_to do
    json.show repository_path repository
  end
end
json.count @filter.count
