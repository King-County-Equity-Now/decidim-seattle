class EnablePostgisExtension < ActiveRecord::Migration[5.2]
  def up
    execute "CREATE EXTENSION IF NOT EXISTS postgis"
    execute "CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder CASCADE"
  end

  def down
    execute "DROP EXTENSION IF EXISTS postgis_tiger_geocoder"
    execute "DROP EXTENSION IF EXISTS postgis"
  end
end
