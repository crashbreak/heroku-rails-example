# Rails heroku example for crashbreak.com

## Setup

####Crashbreak
Read about crashbreak setup [here](https://github.com/crashbreak/crashbreak). Also you can check the [crashbreak.rb](https://github.com/crashbreak/heroku-rails-example/blob/master/config/initializers/crashbreak.rb) file.

####Heroku build
This project uses [heroku-buildpack-multi](https://github.com/ddollar/heroku-buildpack-multi) and [heroku-buildpack-toolbelt](https://github.com/gregburek/heroku-buildpack-toolbelt). This is important when you want to use database dumper. To dump your database you need to have access to heroku commands avaliable via CLI (e.g heroku pg:backups capture). You can add more buildpacks or edit existing one in  [.buildpacks](https://github.com/crashbreak/heroku-rails-example/blob/master/.buildpacks) file.

####Deploy tracking
You can track deploys by enable free heroku addon:

``heroku addons:add deployhooks:http --url="http://www.crashbreak.com/api/projects/YOUR_PROJECT_ACCESS_TOKEN/deploys/?environment=production"``
