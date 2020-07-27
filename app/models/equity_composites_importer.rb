module EquityCompositesImporter
  def self.import!
    connection = ActiveRecord::Base.connection
    sql = File.read('db/equity_composites.sql')

    connection.execute(sql)
  end
end
