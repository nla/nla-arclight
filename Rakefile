# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks if Rake::Task.tasks.empty?

require "solr_wrapper/rake_task" unless Rails.env.production? || Rails.env.staging?
