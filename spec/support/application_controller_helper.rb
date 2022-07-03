RSpec.configure do |config|
  config.before type: :controller do
    config.render_views
  end
end
