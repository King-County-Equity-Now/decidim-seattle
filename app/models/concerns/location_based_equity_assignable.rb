module LocationBasedEquityAssignable
  extend ActiveSupport::Concern

  included do
    before_save :assign_equity_composite_index_if_necessary
  end

  private

  def assign_equity_composite_index_if_necessary
    return unless latitude_changed? or longitude_changed?

    equity_composite = EquityComposite.contains_point(longitude, latitude).first
    self.equity_composite_index_percentile = equity_composite&.composite_index_percentage
  end
end