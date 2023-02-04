# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount API::Root => '/'
  mount Sidekiq::Web => '/sidekiq'
  mount GrapeSwaggerRails::Engine, at: '/documentation'
end
