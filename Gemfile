# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

# Run updates by following the Decidim upgrade instructions:
# https://github.com/decidim/decidim/blob/master/docs/getting_started.md#keeping-your-app-up-to-date
DECIDIM_VERSION = { git: "https://github.com/decidim/decidim", branch: "release/0.21-stable" }
DECIDIM_MODULE_VERSION = "0.21.0"

gem "decidim", DECIDIM_VERSION
gem "decidim-initiatives", DECIDIM_VERSION

# Change term_customizer dependency to ruby-gems' when term-customizer is compatible with DECIDIM_VERSION
gem "decidim-term_customizer", git: "https://github.com/mainio/decidim-module-term_customizer", branch: "0.21-stable"

# Install the git modules until they have an actual release
gem "decidim-plans", git: "https://github.com/mainio/decidim-module-plans"
gem 'decidim-navbar_links', git: "https://github.com/OpenSourcePolitics/decidim-module-navbar_links", branch: "0.21-stable"

gem "puma"
gem "uglifier"
gem "wicked_pdf"
gem "wkhtmltopdf-binary"
gem "ruby-cldr", "~> 0.3.0"
gem "font-awesome-rails", "~> 4.7.0"

# This module seems useful, but is still on Decidim 0.19.
#gem "decidim-combined_budgeting", git: "https://github.com/mainio/decidim-module-combined_budgeting"

# Postgis
gem 'activerecord-postgis-adapter'

# HKI export
gem "rubyXL", "~> 3.4", ">= 3.4.6"

group :development, :test do
  gem "byebug", platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "faker", "1.9.5"
  gem "rspec-activemodel-mocks"
end

group :development do
  gem "letter_opener_web"
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"
  gem "web-console"
end

group :production, :staging do
  gem "fog-aws"
  gem "dotenv-rails"

  # resque-scheduler still depends on resque ~> 1.25
  # Keep an eye on:
  # https://github.com/resque/resque-scheduler/pull/661
  gem "resque", "~> 1.26"
  gem "resque-scheduler", "~> 4.0"
end

group :test do
  gem "database_cleaner"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
