# frozen_string_literal: true

# Rakefile
require 'rake/testtask'

CODE = 'app/'
task :default do
  puts `rake -T`
end

desc 'Run unit and integration tests'
Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.warning = false
end

desc 'Run home page acceptance tests'
Rake::TestTask.new(:spec_accept) do |t|
  t.pattern = 'spec/tests_acceptance/*_acceptance.rb'
  t.warning = false
end

namespace :run do
  desc 'Run API in dev mode'
  task :dev do
    sh 'rerun -c "rackup -p 9090"'
  end

  desc 'Run API in test mode'
  task :test do
    sh 'RACK_ENV=test rackup -p 9090'
  end
end

# task :home_spec do
#   puts 'NOTE: run `rake run:test` in another process'
#   sh 'ruby spec/tests_acceptance/home_page_acceptance.rb'
# end

# desc 'Run result page acceptance tests'
# task :result_spec do
#   puts 'NOTE: run `rake run:test` in another process'
#   sh 'ruby spec/tests_acceptance/result_page_acceptance.rb'
# end

desc 'Run tests'
task :spec do
  sh 'ruby spec/tests_intergration/api_spec.rb'
  puts 'Tests executed'
end

desc 'Run tests'
task :gateway_spec do
  sh 'ruby spec/test_unit/gateway_api_spec.rb'
  puts 'Tests executed'
end

desc 'Run tests'
task :database_spec do
  sh 'ruby spec/tests_intergration/gateway_database_spec.rb'
  puts 'Tests executed'
end

desc 'Run example'
task :example do
  sh 'ruby example/api_test.rb'
  puts 'Api Example executed'
end

desc 'Run example'
task :view_test do
  sh 'ruby example/view_object.rb'
  puts 'View object test Example executed'
end

namespace :quality do
  desc 'Check Flog'
  task :flog do
    sh "flog #{CODE}"
    puts 'Flog executed'
  end

  desc 'Smell the code'
  task :reek do
    sh "reek #{CODE}"
    puts 'Code smelled'
  end

  desc 'Check rubocop violations'
  task :rubocop do
    sh 'rubocop'
    puts 'Rubocup checked'
  end
end

# desc 'Run tests once'
# Rake::TestTask.new(:spec) do |t|
#   t.pattern = 'spec/*_spec.rb'
#   t.warning = false
# end

namespace :db do
  task :config do
    require 'sequel'
    require_relative 'config/environment' # load config info
    # require_relative 'spec/helpers/database_helper'

    def app
      THSRParking::App
    end
  end

  desc 'Run migrations'
  task :migrate => :config do
    Sequel.extension :migration
    puts "Migrating #{app.environment} database to latest"
    Sequel::Migrator.run(app.DB, 'app/infrastructure/database/migrations')
  end

  desc 'Insert init Parks and City data in database'
  task :init_data => :config do
    require_relative 'app/infrastructure/database/scripts/park_script'
    require_relative 'app/infrastructure/database/scripts/city_script'

    THSRParking::DatabaseScript::Parks.new.init
    puts "Successfully init parks data in #{app.environment} database to latest"

    THSRParking::DatabaseScript::City.new.init
    puts "Successfully init city data in #{app.environment} database to latest"
  end

  desc 'Wipe records from all tables'
  task :wipe => :config do
    DatabaseHelper.setup_database_cleaner
    DatabaseHelper.wipe_database
  end

  desc 'Delete dev or test database file'
  task :drop => :config do
    if app.environment == :production
      puts 'Cannot remove production database!'
      return
    end

    FileUtils.rm(THSRParking::App.config.DB_FILENAME)
    puts "Deleted #{THSRParking::App.config.DB_FILENAME}"
  end
end

desc 'Run application console (irb)'
task :console do
  sh 'irb -r ./init'
end

desc 'Run tests'
task :api_spec do
  sh 'ruby spec/tests_acceptance/api_spec.rb'
  puts 'api_spec Tests executed'
end

namespace :queues do
  task :config do
    require 'aws-sdk-sqs'
    require_relative 'config/environment' # load config info
    @api = THSRParking::App

    @sqs = Aws::SQS::Client.new(
      access_key_id: @api.config.AWS_ACCESS_KEY_ID,
      secret_access_key: @api.config.AWS_SECRET_ACCESS_KEY,
      region: @api.config.AWS_REGION
    )
  end

  desc 'Create SQS queue for worker'
  task :create => :config do
    puts "Environment: #{@api.environment}"
    @sqs.create_queue(queue_name: @api.config.PARK_QUEUE)

    q_url = @sqs.get_queue_url(queue_name: @api.config.PARK_QUEUE).queue_url
    puts 'Queue created:'
    puts "  Name: #{@api.config.PARK_QUEUE}"
    puts "  Region: #{@api.config.AWS_REGION}"
    puts "  URL: #{q_url}"
  rescue StandardError => e
    puts "Error creating queue: #{e}"
  end

  desc 'Report status of queue for worker'
  task :status => :config do
    q_url = @sqs.get_queue_url(queue_name: @api.config.PARK_QUEUE).queue_url

    puts "Environment: #{@api.environment}"
    puts 'Queue info:'
    puts "  Name: #{@api.config.PARK_QUEUE}"
    puts "  Region: #{@api.config.AWS_REGION}"
    puts "  URL: #{q_url}"
  rescue StandardError => e
    puts "Error finding queue: #{e}"
  end

  desc 'Purge messages in SQS queue for worker'
  task :purge => :config do
    q_url = @sqs.get_queue_url(queue_name: @api.config.PARK_QUEUE).queue_url
    @sqs.purge_queue(queue_url: q_url)
    puts "Queue #{queue_name} purged"
  rescue StandardError => e
    puts "Error purging queue: #{e}"
  end
end