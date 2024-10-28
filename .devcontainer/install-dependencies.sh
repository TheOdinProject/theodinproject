# Install and use ruby 3.3.5 as default; our Docker image uses rvm
rvm install 3.3.5
rvm use 3.3.5

# Display current ruby version (for logging)
ruby -v

# Remove tooling that causes build issues
gem uninstall -i /usr/local/rvm/rubies/ruby-3.3.5/lib/ruby/gems/3.3.0 gem-wrappers

# Install required gems
bundle install

# Install required JS dependencies
yarn install

# Prepare .env
cp env.sample .env

# Install Chrome (for running tests)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    sudo apt update && \
    sudo apt install ./google-chrome-stable_current_amd64.deb -y && \
    rm ./google-chrome-stable_current_amd64.deb

# Set up your database
rails db:create
rails db:environment:set RAILS_ENV=development
rails db:schema:load

# Remind user how to get started
echo
echo To get started you can run your tests by running this command:
echo
echo   bin/rspec
echo
echo ...or you can run the web site by running this command:
echo
echo   bin/dev
echo