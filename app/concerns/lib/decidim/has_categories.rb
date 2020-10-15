# frozen_string_literal: true

require "active_support/concern"

module Lib
  module Decidim
    # A concern with the components needed when you want a model to have a category.
    module HasCategories
      extend ActiveSupport::Concern

      included do
        has_many :categorizations, foreign_key: "categorizable_id", class_name: "Decidim::Categorization", dependent: :destroy
        has_many :categories, through: :categorizations

        #validate :category_belongs_to_organization
        #
        #def   previous_category
        #  return if categorization.versions.count <= 1
        #
        #  Decidim::Category.find_by(id: categorization.versions.last.reify.decidim_category_id)
        #end
        #
        #private
        #
        #def category_belongs_to_organization
        #  return unless category
        #
        #  errors.add(:category, :invalid) unless component.categories.where(id: category.id).exists?
        #end
      end
    end
  end
end
