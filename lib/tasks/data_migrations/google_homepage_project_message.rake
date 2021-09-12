# rubocop:disable all
namespace :data_migrations do

  desc "Create Google Homepage Project Admin Flash"
  task create_google_homepage_project_message: :environment do

    puts "Creating Message"

    AdminFlash.create!(
      message: "The former Google Homepage project is causing some users to have their GitHub Pages sites flagged as malicious. If you have completed the Google Homepage project we suggest you disable its GitHub Pages deployment as soon as possible.",
      expires: 2.weeks.from_now,
    )
  end
end
