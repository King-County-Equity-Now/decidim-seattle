require 'active_support/concern'

module EquityCompositeIndexAdminFixes
  extend ActiveSupport::Concern

  included do
    # Modifies the default update_proposal method in order to update equity_composite_index_percentile
    def update_proposal
        Decidim.traceability.update!(
          proposal,
          form.current_user,
          title: title_with_hashtags,
          body: body_with_hashtags,
          category: form.category,
          scope: form.scope,
          address: form.address,
          latitude: form.latitude,
          longitude: form.longitude,
          created_in_meeting: form.created_in_meeting,
          equity_composite_index_percentile: form.equity_composite_index_percentile
        )
      end
  end
end
