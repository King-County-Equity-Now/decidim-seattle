require 'active_support/concern'

module EquityQuintilePresenterExtensions
  extend ActiveSupport::Concern

  included do
    def equity_quintile
      (proposal.equity_composite_index_percentile.round(2) * 5).floor() + 1
    end
  end
end
  