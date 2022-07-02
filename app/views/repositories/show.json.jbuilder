json.repository do
  json.extract! @repository, :id, :name, :full_name, :description, :external_id, :metadata, :created_at, :updated_at
end
