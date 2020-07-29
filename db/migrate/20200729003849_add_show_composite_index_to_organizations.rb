class AddShowCompositeIndexToOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_organizations, :show_equity_composite_index, :boolean, null: false, default: true
  end
end
