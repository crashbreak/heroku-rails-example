Crashbreak.configure do |config|
  config.api_key = ENV['CRASHBREAK_TOKEN']

  # config.exception_notifier = Crashbreak::ExceptionNotifier.new
  config.exception_notifier = Crashbreak::ForkExceptionNotifier.new

  config.error_serializers = [Crashbreak::DefaultSummarySerializer.new, Crashbreak::EnvironmentVariablesSerializer.new]
  config.dumpers = [Crashbreak::RequestDumper.new, Crashbreak::DatabaseDumper.new]

  config.dumper_options = {
      aws_bucket_name: 'cb-test-app',
      aws_region: 'us-east-1',
  }

  config.github_integration = true
  config.github_login = ENV['GITHUB_USER']
  config.github_password = ENV['GITHUB_PASSWORD']
  config.github_repo_name = 'crashbreak/heroku-rails-example'

  config.ignored_environments = []
end

if Rails.env.production?
  Crashbreak::PredefinedSettings.heroku_postgresql('Gold', 'crashbreak-rails-example')
else
  Crashbreak::PredefinedSettings.postgresql('heroku_rails_example_development')
end

