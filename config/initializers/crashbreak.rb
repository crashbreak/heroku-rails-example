Crashbreak.configure do |config|
  config.api_key = 'Ai-_TqHX3EmueSKcl67X2g'

  config.error_serializers = [Crashbreak::DefaultSummaryFormatter.new, Crashbreak::EnvironmentVariablesFormatter.new]
  config.dumpers = [RequestDumper.new]
end