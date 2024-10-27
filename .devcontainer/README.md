
These files in `/.devcontainer` let you use services like GitHub Codespaces to quickly get up and running with The Odin Project

You'll still to do some setup after starting your dev container:
```bash
 # Install ruby-3.3.5 for rvm
rvm install "ruby-3.3.5"

# Remove a tool that will cause build issues
gem uninstall -i /usr/local/rvm/rubies/ruby-3.3.5/lib/ruby/gems/3.3.0 gem-wrappers

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
```

> Note: If you think some of this could be automated, you're probably right. Open a pull request with those changes that can give other engineers a turbo boost!