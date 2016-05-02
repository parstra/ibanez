require "bundler/gem_tasks"
require 'ibanez'

#task :default => :spec
desc 'Download the countries configuration from wikipedia'
task :fetch_config do
  Ibanez::Tools.fetch_yml
end
