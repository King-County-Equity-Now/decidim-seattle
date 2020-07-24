# frozen_string_literal: true

# Run rake db:seed:equity_composite_index to load the equity composite index data

namespace :db do
  namespace :seed do
    desc "Load equity composite index data"
    task equity_composite_index: :environment do
      unless Rails.env.production?
        connection = ActiveRecord::Base.connection
        sql = File.read('db/equity_composites.sql')

        connection.execute(sql)
      end
    end
  end
end
