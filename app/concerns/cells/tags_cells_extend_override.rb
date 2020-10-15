# frozen_string_literal: true

require 'active_support/concern'

# Include all classes and modules that extend or override Decidim::TagsCell here
# cause it's not possible to use send method multiple times in the application.rb

module Cells
  module TagsCellsExtendOverride
    extend ActiveSupport::Concern

    included do

      include Cells::Decidim::AddCategoriesOverrides
      include TagsCellEquityExtensions
    end
  end
end
