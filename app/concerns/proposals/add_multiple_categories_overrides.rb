# frozen_string_literal: true

require 'active_support/concern'

module Proposals
  module AddMultipleCategoriesOverrides
    extend ActiveSupport::Concern

    included do
      include Lib::Decidim::HasCategories
    end
  end
end
