Crashbreak.configure do |config|
  config.api_key = ENV['CRASHBREAK_TOKEN']

  # config.exception_notifier = Crashbreak::ExceptionNotifier.new
  config.exception_notifier = Crashbreak::ForkExceptionNotifier.new

  config.error_serializers = [Crashbreak::DefaultSummaryFormatter.new, Crashbreak::EnvironmentVariablesFormatter.new]
  config.dumpers = [RequestDumper.new, Crashbreak::DatabaseDumper.new]

  config.dumper_options = {
      aws_bucket_name: 'cb-test-app',
      aws_region: 'us-east-1',
  }

  config.github_login = ENV['GITHUB_USER']
  config.github_password = ENV['GITHUB_PASSWORD']
  config.github_repo_name = 'crashbreak/heroku-rails-example'
end

if Rails.env.production?
  Crashbreak::PredefinedSettings.new.heroku_postgresql('Gold', 'crashbreak-rails-example')
else
  Crashbreak::PredefinedSettings.new.mongodb('heroku_rails_example_development_mongo')
end

