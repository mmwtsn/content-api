# Guard task runner conf file
guard :rspec do
  # Run entire test suite when anythin in /app/{models,controllers,views} is changed
  watch(%r{^app/(.+)\.rb$}) { 'spec' }
  watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$}) { 'spec' }

  # Run entire test suite when specs or factories are changed
  watch(%r{^spec/features/.+_spec\.rb$}) { 'spec' }
  watch(%r{^spec/factories.rb$}) { 'spec' }
end
