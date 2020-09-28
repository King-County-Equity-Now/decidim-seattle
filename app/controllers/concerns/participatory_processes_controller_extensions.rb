# frozen_string_literal: true

require "active_support/concern"

module ParticipatoryProcessesControllerExtensions
  include Decidim::ParticipatoryProcesses
  extend ActiveSupport::Concern

  included do
    def index
     raise ActionController::RoutingError, "Not Found" if published_processes.none?

     enforce_permission_to :list, :process
     enforce_permission_to :list, :process_group

    # redirect to the process if there's only one published process
     if published_processes.count == 1
        redirect_to action: "show", slug:published_processes.first.slug
      end
    end

    private
    
    def published_processes
      @published_processes ||= Decidim::ParticipatoryProcesses::OrganizationPublishedParticipatoryProcesses.new(current_organization, current_user)
    end
  end
end