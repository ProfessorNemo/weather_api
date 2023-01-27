# frozen_string_literal: true

namespace :download do
  desc 'Downloading data from server'

  task from_api: :environment do
    puts 'Downloading data'

    GetClient.new.create_data
  end
end
