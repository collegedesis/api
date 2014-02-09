namespace :db do
  desc  'Seed a fresh database for development and staging environments'
  task reset_dev: :environment do
    reset_database(Rails.env)
    load "#{Rails.root}/db/seeds_dev.rb"
  end

  def reset_database(env)
    case env
    when "development"
      puts "Running rake db:reset in #{env}"
      %x[rake db:reset]
    when "staging"
      puts "Running pg:reset in #{env}"
      %x[pg:reset]
      %x[rake db:seed]
    when "production"
      puts "This task is not available in #{env}"
    end
  end
end
