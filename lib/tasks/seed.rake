namespace :db do
  desc "Load seed data only if the database is empty"
  task seed_if_necessary: :environment do
    unless Decidim::Organization.exists?
      Rake::Task['db:seed'].invoke
    end
  end
end