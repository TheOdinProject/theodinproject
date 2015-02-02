namespace :email do
  
  desc "create basic email campaign categories"
  task :create_campaign_categories => :environment do
    categories = [
      { name: "All", 
        description: "All categories"
      },
      { name: "Nudges", 
        description: "Friendly reminders and encouragement to keep coding"
      },
      { name: "Newletters", 
        description: "Information of interest to the community"
      },
      { name: "Marketing",
        description: "Offers and information about other services"
      }
    ]
    categories.each do |category|
      EmailCampaignCategory.find_or_create_by!(name: category.fetch(:name)) do |c|
        c.description = category.fetch(:description)
      end
    end
  end
end
