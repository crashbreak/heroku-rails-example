Crashbreak.configure do |config|
  config.api_key = ENV['CRASHBREAK_TOKEN']

  # config.exception_notifier = Crashbreak::ExceptionNotifier.new
  config.exception_notifier = Crashbreak::ForkExceptionNotifier.new # use sidekiq

  config.error_serializers = [Crashbreak::DefaultSummaryFormatter.new, Crashbreak::EnvironmentVariablesFormatter.new]
  config.dumpers = [RequestDumper.new, Crashbreak::DatabaseDumper.new]

  config.dumper_options = {
      aws_bucket_name: 'cb-test-app',
      aws_region: 'us-east-1',

      dump_location: "#{Rails.root}/tmp/db.dump",
      dump_command:
        '/app/vendor/heroku-toolbelt/bin/heroku pg:backups capture Gold -a crashbreak-rails-example &&' +
        "curl -o #{Rails.root}/tmp/db.dump `/app/vendor/heroku-toolbelt/bin/heroku pg:backups public-url --app crashbreak-rails-example`"
  }

  config.restorer_options = { restore_command: "pg_restore -O #{Rails.root}/tmp/db.dump -d crashbreak-test" }

  config.github_login = ENV['GITHUB_USER']
  config.github_password = ENV['GITHUB_PASSWORD']
  config.github_repo_name = 'crashbreak/heroku-rails-example'
end