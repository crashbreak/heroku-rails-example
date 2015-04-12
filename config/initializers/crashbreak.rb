Crashbreak.configure do |config|
  config.api_key = 'Ai-_TqHX3EmueSKcl67X2g'

  # config.exception_notifier = Crashbreak::ExceptionNotifier.new
  config.exception_notifier = Crashbreak::AsyncExceptionNotifier # use sidekiq

  config.error_serializers = [Crashbreak::DefaultSummaryFormatter.new, Crashbreak::EnvironmentVariablesFormatter.new]
  config.dumpers = [RequestDumper.new, Crashbreak::DatabaseDumper.new]

  config.dumper_options = {
      aws_bucket_name: 'cb-test-app',
      aws_region: 'us-east-1',
      aws_access_key_id: 'fake_aws_key_id',
      aws_secret_access_key: 'fake_aws_secret_key',

      dump_location: "#{Rails.root}/tmp/db.dump",
      dump_command:
        '/app/vendor/heroku-toolbelt/bin/heroku pg:backups capture Gold -a crashbreak-rails-example &&' +
        "curl -o #{Rails.root}/tmp/db.dump `/app/vendor/heroku-toolbelt/bin/heroku pg:backups public-url --app crashbreak-rails-example`"
  }

  config.restorer_options = { restore_command: "pg_restore #{Rails.root}/tmp/db.dump -d crashbreak-test" }
end