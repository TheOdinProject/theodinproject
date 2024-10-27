These files enable you to quickly get up and running with The Odin Project in a dev container

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

# Install Chrome (for running tests)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y
rm ./google-chrome-stable_current_amd64.deb

# Set up your database
rails db:create
rails db:environment:set RAILS_ENV=development # I think I can set this in the docker-compose
rails db:schema:load
```

> Note: If you think some of this could be automated, you're probably right! Open a pull request with those changes that can give other engineers a turbo boost!