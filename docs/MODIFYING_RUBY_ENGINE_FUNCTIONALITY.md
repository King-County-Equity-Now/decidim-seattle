# Modifying Ruby Engine Functionality

## Background

The Decidim project is organized into a large set of [modules](https://decidim.org/modules/). You can see what modules are being used by looking at the `decidim-seattle` [Gemfile](https://github.com/substantial/decidim-seattle/blob/master/Gemfile#L13-L31).

According to Decidim's documentation,

> If you need to have some features that we don’t have yet, we recommend that you make a module. This is a Ruby on Rails engine with some APIs specific to Decidim (for registering with the menus, integration with spaces like Participatory Processes or Assemblies, with /admin or /api, etc).

Organizing a larger feature set into a standalone module makes sense, but you might encounter a situation where you need to extend the behavior of an existing module.

## How to modify an existing module class

During development, it can be cumbersome to modify the contents of a module class directly, since it requires importing a development branch of the gem, updating the gem code directly, and releasing a new version of the gem, which might not necessarily be compatible with the `decidim-seattle` app. Therefore, in order to move quickly, you can override or extend the behavior of module classes.


### Overriding 

Overriding can make sense if you need to totally replace the behavior of a module class. 

[Learn more at the rails engine docs.](https://guides.rubyonrails.org/v5.1/engines.html#overriding-models-and-controllers)

The approach for overriding is to duplicate the module class and place it in the main app directory.

For example, adding an implementation of `Decidim::Proposals::Admin:Permission` to  `app/permissions/decidim/proposals/admin/permissions.rb` would override the behavior of `permission.rb` found in the `decidim-proposals` gem. Placing the overriden file into the correct directory

Note: This is not the recommended approach for the `decidim-seattle` project at this time, due to the fact that any updates from the main Decidim gems would not be picked up by the overridden files.

### Extending

The preferred way to extend a module class is by using [`ActiveSupport::Concern`](https://api.rubyonrails.org/v5.1.7/classes/ActiveSupport/Concern.html).

An example is provided:

#### Add a Concern

in `app/presenters/concerns/equity_quintile_presenter_fixes.rb `
```ruby
require 'active_support/concern'

module EquityQuintilePresenterExtensions
  extend ActiveSupport::Concern

  included do
    def equity_quintile
      (proposal.equity_composite_index_percentile.round(2) * 5).floor() + 1
    end
  end
end
```
#### Tell the main Rails application to send the concern to the appropriate class

in `config/application.rb#config.to_prepare`:

```ruby
# Proposals extensions
Decidim::Proposals::ProposalPresenter.send(:include, EquityQuintilePresenterExtensions)
```
