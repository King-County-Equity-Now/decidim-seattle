# frozen_string_literal: true

# Run rake db:seed:equity_composites to load the equity composite index data

namespace :db do
  namespace :seed do
    desc "Load equity composite index data"
    task equity_composites: :environment do
      EquityCompositesImporter.import!
    end
  end
end
