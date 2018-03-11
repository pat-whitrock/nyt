require_relative 'config/application'

Rails.application.load_tasks

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task default: :spec
