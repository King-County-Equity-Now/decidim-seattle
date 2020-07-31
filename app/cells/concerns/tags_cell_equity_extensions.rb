require 'active_support/concern'

module TagsCellEquityExtensions
  extend ActiveSupport::Concern

  included do
    def show
      render if category? || scope? || equity?
    end

    def equity
      render if equity?
    end

    private

    def proposal_path
      resource_locator(model).path
    end

    def equity?
      current_organization.show_equity_composite_index? &&
        model.has_attribute?(:equity_composite_index_percentile) &&
        model.equity_composite_index_percentile != nil
    end

    def equity_name
      title = I18n.t("card_tag_title", scope: "decidim.proposals.equity")
      quintile = I18n.t("quintile#{equity_quintile}", scope: "decidim.proposals.equity")

      "#{title} #{quintile}"
    end

    def equity_quintile
      equity_percentile = model.equity_composite_index_percentile.round(2) * 100

      return Integer(equity_percentile / 20) + 1
    end
  end
end
