# frozen_string_literal: true
require 'active_support/concern'

module UpdateProposalOverrides
  extend ActiveSupport::Concern

  included do
    def attributes
      {
          title: 'title_with_hashtags',
          body: 'body_with_hashtags',
          categories: form.categories,
          category: form.category,
          scope: form.scope,
          address: form.address,
          latitude: form.latitude,
          longitude: form.longitude
      }
    end
  end
end
