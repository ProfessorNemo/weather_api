# frozen_string_literal: true

module API
  class Root < ::Grape::API
    version 'v1', using: :path
    format :json
    content_type :json, 'application/json; charset=utf-8'
    prefix :api

    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Allow-Methods'] = 'GET'
      header['X-Forwarded-Proto'] = 'http'
      header['Host'] = 'localhost:3000'
      header['Date'] = Time.zone.now
    end

    mount API::V1::Weather

    add_swagger_documentation(
      info: {
        title: 'API-Weather',
        description: 'The API contains statistical data on the' \
                     'air temperature in the selected city per day',
        contact_name: 'Professor Moriarty',
        contact_email: 'gleboceanborn@gmail.com',
        contact_url: 'https://github.com/ProfessorNemo'
      },
      api_version: 'v1',
      hide_documentation_path: true,
      hide_format: true,
      host: 'localhost:3000',
      mount_path: '/documentation',
      add_version: true,
      doc_version: '0.0.1',
      token_owner: 'resource_owner',
      resource: 'api.accuweather.com',
      resource_access_security_definitions: {
        api_key: {
          type: 'apiKey',
          name: 'apikey',
          in: 'params'
        }
      }
    )
  end
end
