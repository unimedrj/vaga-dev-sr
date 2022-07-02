# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

result = JSON.load_file(Rails.root.join('spec', 'support', 'api.github.com', 'repositories.json')).first
100.times do |i|
  result['id'] = i + 1
  FactoryBot.create(:repository, result:)
end
