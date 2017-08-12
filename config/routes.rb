require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json },
                  constraints: { subdomain: 'api' },
                  path: '/' do # namespace as the folder in app/controllers/api # check available MIME types by typing `$ Mime::SET.collect(&:to_s)
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do

    end
  end
end
