require 'rails/generators'

class Rails::SeedUuidsGenerator < Rails::Generators::Base
  def generate_uuids
    seed_files = Dir.glob('db/fixtures/**/*').reject { |f| File.directory?(f) }

    seed_files.each do |file_name|
      gsub_file file_name, 'create_uuid' do
        SecureRandom.uuid
      end
    end
  end
end
