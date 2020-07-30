require 'active_support/concern'

module UpdateOrganizationOverrides
  extend ActiveSupport::Concern

  included do
    # Modifies attributes method to add `show_equity_composite_index`
    def attributes
      {
        name: form.name,
        default_locale: form.default_locale,
        reference_prefix: form.reference_prefix,
        twitter_handler: form.twitter_handler,
        facebook_handler: form.facebook_handler,
        instagram_handler: form.instagram_handler,
        youtube_handler: form.youtube_handler,
        github_handler: form.github_handler,
        badges_enabled: form.badges_enabled,
        user_groups_enabled: form.user_groups_enabled,
        show_equity_composite_index: form.show_equity_composite_index,
      }.merge(welcome_notification_attributes)
    end
  end
end
