RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

drop:
	rails db:drop

install:
	rails db:create
	rails db:migrate
	rake download:from_api

rubocop:
	rubocop -A

run-console:
	bundle exec rails console

rspec:
	bundle exec rspec spec/models/weather_forecast.rb
	bundle exec rspec spec/lib/api/v1/weather_spec.rb
	bundle exec rspec spec/service/get_client_spec.rb
	bundle exec rspec spec/jobs/sidekiq_schedululer_spec.rb
	bundle exec rspec spec/jobs/forecast_job_spec.rb

stop:
	sudo kill -9 `sudo lsof -t -i:3000`

c: run-console

.PHONY: db default
default:
	bash stop.sh
