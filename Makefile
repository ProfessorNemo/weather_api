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
	bundle exec rspec spec/lib/api/v1/weather_spec.rb

c: run-console

.PHONY:	db
