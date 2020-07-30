require 'active_support/concern'

module OrganizationFormExtensions
  extend ActiveSupport::Concern

  included do
    attribute :show_equity_composite_index, ActiveRecord::Type::Boolean
  end
end
