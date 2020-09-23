if Rails.application.secrets.dig(:omniauth, :auth0).present?
    Rails.application.config.middleware.use OmniAuth::Builder do
        provider(
            :auth0,
            setup: ->(env) {
                request = Rack::Request.new(env)
                organization = Decidim::Organization.find_by(host: request.host)
                provider_config = organization.enabled_omniauth_providers[:auth0]
                env["omniauth.strategy"].options[:client_id] = provider_config[:client_id]
                env["omniauth.strategy"].options[:client_secret] = provider_config[:client_secret]
                env["omniauth.strategy"].options[:domain] = provider_config[:domain]
            },
            scope: :public
        )
    end
end
