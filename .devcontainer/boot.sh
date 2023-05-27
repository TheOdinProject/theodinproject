#!/bin/bash

echo "Setting SSH password for vscode user..."
sudo usermod --password "$(echo vscode | openssl passwd -1 -stdin)" vscode

echo "Updating RubyGems..."
gem update --system -N

echo "Installing dependencies..."
bundle install
yarn install

echo "Copying database.yml..."
cp -n config/database.yml.example config/database.yml

echo "Creating database..."
bin/rails db:create db:migrate db:seed

echo "Done!"
