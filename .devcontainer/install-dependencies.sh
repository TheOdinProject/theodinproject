# Install ruby-3.3.5 for rbenv
rbenv install 3.3.5 --verbose

# Remove a tool that will cause build issues... is this even a thing if I'm not using rvm?
# gem uninstall -i /usr/local/rvm/rubies/ruby-3.3.5/lib/ruby/gems/3.3.0 gem-wrappers

# Install required gems
bundle install

# Install required JS dependencies
yarn install

# Prepare .env
cp env.sample .env

# Manually update .env with postgres username and password; default is "postgres" for both
# POSTGRES_USERNAME: 'postgres'
# POSTGRES_PASSWORD: 'postgres

# Install Chrome (for running tests)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    sudo apt update && \
    sudo apt install ./google-chrome-stable_current_amd64.deb -y && \
    rm ./google-chrome-stable_current_amd64.deb

# Set up your database
rails db:create
rails db:environment:set RAILS_ENV=development
rails db:schema:load