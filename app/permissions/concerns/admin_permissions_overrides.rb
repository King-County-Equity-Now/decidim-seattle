require 'active_support/concern'

module AdminPermissionsOverrides
  extend ActiveSupport::Concern

  included do
    def admin_edition_is_available?
        return unless proposal

        # Always allow admins to edit proposals.
        true
      end
  end
end
  