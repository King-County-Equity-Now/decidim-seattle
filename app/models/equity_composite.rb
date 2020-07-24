# frozen_string_literal: true

# A EquityComposite record represents a Race and Social Equity Data record produced by the
# City of Seattle Office of Planning & Community Development.
#
# You can populate this data with /bin/rails db:seed:equity_composite_index or bin/rails db:setup
#
class EquityComposite < ApplicationRecord
  self.ignored_columns = %w(geom)
  scope :contains_point, ->(long, lat) { where("ST_Contains(geom, ST_Point(?, ?))", long, lat) }
end
