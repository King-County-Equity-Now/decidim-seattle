# King County Equity Now - Seattle Participatory Budgeting Site

This participatory democracy system is built on the City of Helsinki's fork of the Decidim platform.

Please check out their README's and documentation for instructions:

- [Decidim](https://github.com/decidim/decidim)
- [City of Helsinki's modified fork of Decidim](https://github.com/City-of-Helsinki/decidim-helsinki)

## Setup

### Setup (mac)

Run `script/dev-setup` and follow the instructions until you see:

`>> You're all set up!`

Note: people sometimes run into problems with database connection issues. If that's the case, chances are postgres is shutting down right after starting up and to find out why, run `brew info postgresql` and check out the instructions on how to start postgresql manually and try that. That's usually enough to get people unblocked.

What all it's going to do:

- Install the asdf package manager (if you prefer rbenv, check out the windows/linux setup below)
- Install Ruby via asdf
- Install PostgreSQL, PostGIS, ImageMagick via homebrew
- Create and migrate the database
- Seed the database with sample data if it's empty

It's intended to be an idempotent script, so you can run it multiple times and it'll only change
what needs to be changed, so feel free to run it often.

### Setup (windows/linux, or people who hate the streamlined script for whatever reason)

Please see the core Decidim docs:
https://github.com/decidim/decidim/blob/master/docs/getting_started.md

Then install PostGIS:
https://postgis.net/install/

### Setup (Docker)

Run `bin/docker build` and then `bin/docker start`. You should be able to go to http://localhost:3000 when the process is complete. The initial build and first page load will take some time.

The Dockerfile will create a postgres database (pg-data) and redis (redis-data) directories that will be persistent across containers.

To enter the container in a bash environment, run `bin/docker bash`. To enter the postgres container using psql, run `bin/docker pg`

## Running the server

`bin/rails server`

Alternately, if you'd like to run `script/dev-setup` every time before starting the server, you can do that with:

`script/dev-start`

## Running the tests

The Helsinki project this was forked from has no tests for the Ruby code, and some minimal testing for the [`decidim-comments` React app](https://github.com/King-County-Equity-Now/decidim-seattle/tree/main/vendor/decidim-comments/app/frontend). We've added a few tests using [`RSpec`](https://rspec.info/) and [`rspec-rails`](https://github.com/rspec/rspec-rails/tree/4-0-maintenance).

### Ruby

To test the ruby code, run

`bundle exec rspec`

Check out the following resources to learn more about our test setup:

* [`RSpec`](https://rspec.info/)
* [`rspec-rails`](https://github.com/rspec/rspec-rails/tree/4-0-maintenance)
* [Ruby's Testing Guide](https://guides.rubyonrails.org/testing.html). We don't use Ruby's built in testing framework, but the concepts and classes are helpful to better understand what `rspec-rails` provides.

### JavaScript

In the unlikely event that you need to modify [the `decidim-comments` React app](https://github.com/King-County-Equity-Now/decidim-seattle/tree/main/vendor/decidim-comments/app/frontend), or a new JS component, run

`npm install && npm test`

## Decidim Documentation and Administration Manual

Documentation and administration manual for Decidim can be found from the
following URLs:

- https://decidim.org/docs/
- https://docs.decidim.org/

## Why Decidim?

We considered both [Consul](https://github.com/consul/consul) and Decidim,
but were strongly recommended by the [The Participatory Budgeting Project](https://www.participatorybudgeting.org/mission/),
a nonprofit that encourages PB processes globally, to use Decidim, as it
better aligns with the steering committee PB model that is used in the US.

## Fork of a fork of a fork?

The City of Helsinki spent a bunch of time and money making some lovely
UI changes to Decidim, and we wanted to piggyback on their good work for
our Seattle Participatory Budgeting site. Additionally, the Helsinki fork has the
most users of any Decidim fork and was well-regarded by the Decidim developers
in its implementation. One particularly useful feature is the ability to merge
multiple similar proposals into a single plan that citizens can vote on.

With all customizations and modifications, try to keep the application as
maintainable as possible against the Decidim core. Try to avoid hard core
customizations which require lots of efforts to maintain over Decidim's core
updates.

## Equity data

One of the main changes we made from the City of Helsinki site (other than the
look and feel) is pulling in quantitative equity data from the City of 
Seattle's [Racial and Social Equity Index](http://data-seattlecitygis.opendata.arcgis.com/datasets/SeattleCityGIS::racial-and-social-equity-composite-index).

The Racial and Social Equity composite index combines information on race,
ethnicity, and related demographics with data on socioeconomic and health
disadvantages to identify where priority populations make up relatively large
proportions of neighborhood residents. 

Our hope is that incorporating and displaying this data empowers the steering
committee and the public to make choices that more directly benefit the
disadvantaged.

### How to update the data source

1. Download the shapefile from the above loink
2. Convert it to an sql dump: `shp2pgsql -d -I -m db/equity_column_mapping 9362e3b7-801d-4b8e-9a79-cf70afe2d10d202037-1-12y9ny2.x61ol.shp equity_composites > db/equity_composites.sql`
3. Run `bin/rails db:seed:equity_composites`

If you get an error about DropGeometryColumn, feel free to remove that line from
the sql dump and re-run. It doesn't seem to be necessary as the entire table is
about to be dropped.

## Deploying

### Setup

1. Ask to be invited to the `staging-substantial` team of ECEN
2. Download and install the [heroku CLI tools](https://devcenter.heroku.com/articles/heroku-command-line)
3. `heroku login`
4. `git remote add heroku-staging https://git.heroku.com/decidim-seattle-staging.git`

### Deploying staging

`git push heroku-staging main`

If you need to run migrations, follow up with:

`heroku run bin/rails db:migrate`

If the site doesn't come back up, check out `heroku logs`. If it says it took took long to start
it probably needs a restart with `heroku restart`. (There's a 240mb pdf generator binary in
decidim-initiatives that makes the first boot take forever.)

### Viewing logs

`heroku logs`

### Running migrations

`heroku run bin/rails db:migrate`

### Heroku documentation

https://devcenter.heroku.com/articles/git

## Modifying Decidim module behavior

If you need to change the behavior of classes in one of Decidim's modules, [learn more here](docs/MODIFYING_RUBY_ENGINE_FUNCTIONALITY.md).

## Urls

- Staging: https://decidim-seattle-staging.herokuapp.com/

## Future work

### Translations

As a proof of concept, we have added Seattle's tier 1 languages to the language
dropdown menu, (i.e. `available_locales` configuration). Decidim does not
support these languages out of the box and additional work will have to be done
to add translations. Reference [this documentation](https://docs.decidim.org/develop/en/advanced/managing_translations_i18n/)
to see the work involved to add full translations.

Because of a bug in the plans module, locales with a hyphen in the name, such
as `zh-Hans`, can't be trivially supported. The bug manifests as an error when
trying to edit plans in the admin interface. In the future, we should fix this
bug. For now, as of 7/21/20, we have worked around this bug by using
non-standard locale names `zhHans` (Chinese Simplified) and `zhHant` (Chinese
Traditional), without a hyphen. These are non-standard locale names. Update
the comment in `decidim.rb` when this issue is resolved.

### Social network authentication

Decidim supports single sign-on with [a variety of social providers](https://github.com/decidim/decidim/blob/master/docs/services/social_providers.md) out of the box. Seattle currently has Google, Facebook, and Twitter login enabled (as defined in `secrets.yml`).

The associated API keys for these services are stored in Heroku environment variables. 

#### Local testing

If you want to test SSO locally, you'll need to generate your own credentials. The [Decidim docs](https://github.com/decidim/decidim/blob/master/docs/services/social_providers.md) will walk you through the process of creating those.

Once generated, copy the correct ENV variable name from `secrets.yml` and place the API key in  `config/development_env.rb`. For example:

```
ENV["OMNIAUTH_FACEBOOK_APP_ID"] = 'key'
ENV["OMNIAUTH_FACEBOOK_APP_SECRET"] = 'secret'
```

Note: when creating Twitter OAuth credentials, make sure to list http://localhost:3000/users/auth/twitter/callback as a Callback URL.
