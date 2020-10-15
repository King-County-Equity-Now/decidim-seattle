# frozen_string_literal: true

require 'active_support/concern'

module Cells
  module Decidim
    module AddCategoriesOverrides
      extend ActiveSupport::Concern

      included do
        def categories
          render if categories?
        end

        private
        def categories?
          model.categories.present?
        end

        def model_categories
          model.categories
        end
      end
    end
  end
end
