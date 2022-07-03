json.repository do
  json.extract! @repository, :id, :language, :name, :full_name, :description, :external_id, :metadata, :created_at, :updated_at
end
