SimpleCov.start 'rails' do
  add_filter 'channels'
  add_filter 'helpers'
  add_filter 'jobs'
  add_filter 'mailers'

  minimum_coverage 93
end
