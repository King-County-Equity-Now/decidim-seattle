# frozen_string_literal: true

require "active_support/concern"

module Decidim
  module Proposals
    # Common logic to ordering resources
    module Orderable
      extend ActiveSupport::Concern

      included do
        include Decidim::Orderable

        private

        # Available orders based on enabled settings
        def available_orders
          @available_orders ||= begin
            available_orders = %w(random recent)
            # begin decidim-seattle modificaton
            available_orders << "most_equitable" if current_organization.show_equity_composite_index?
            # end decidim-seattle modification
            available_orders << "most_voted" if most_voted_order_available?
            available_orders
          end
        end

        def default_order
          if order_by_votes?
            detect_order("most_voted")
          else
            "recent"
          end
        end

        def most_voted_order_available?
          current_settings.votes_enabled? && !current_settings.votes_hidden?
        end

        def order_by_votes?
          most_voted_order_available? && current_settings.votes_blocked?
        end

        def reorder(proposals)
          case order
          # begin decidim-seattle modificaton
          when "most_equitable"
            proposals.order('equity_composite_index_percentile DESC nulls last')
            # end decidim-seattle modification
          when "random"
            proposals.order_randomly(random_seed)
          when "most_voted"
            proposals.order(proposal_votes_count: :desc)
          when "recent"
            proposals.order(published_at: :desc)
          end
        end
      end
    end
  end
end
