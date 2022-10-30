# The Odin Project
![odin logo](app/assets/images/logo.svg)

[The Odin Project](https://www.theodinproject.com/) (TOP) is an open-source curriculum for learning full-stack web 
development. Our mission is to provide a comprehensive curriculum to learn web development for free. We help users learn 
the skills and build the impressive portfolio of projects they need to get hired as a web developer.

----------

## About

_TODO - flesh this out_

This repo contains the TOP app which pulls in lesson content as well as front-end and back-end code. To see the actual 
lesson content that gets pulled in, please go to the [TOP curriculum repo](https://github.com/TheOdinProject/curriculum).

## Useful Links
- [Issue Tracker](https://github.com/TheOdinProject/theodinproject/issues) - for raising bugs or feature requests
- [App Wiki](https://github.com/TheOdinProject/theodinproject/wiki) - for more detailed information about contributing to the app
- [Curriculum Repo](https://github.com/TheOdinProject/curriculum) - where all the lesson content for the website is pulled from
- [Discord Community](https://discord.gg/fbFCkYabZB) - the main meeting point for maintainers and learners
- [Backlog / Project Board](https://github.com/orgs/TheOdinProject/projects/12/views/1) - the current roadmap for the maintainer team
- [Community Forum](https://github.com/TheOdinProject/theodinproject/discussions) - for questions, ideas and chatting with the maintainers

## Tech Stack
The core technologies that the app runs on. This is what you'll need to get the app running locally. 

- **Ruby** for the core language
- **Node** for JavsScript bundling 
- **Yarn** for JavaScript packages
- **Postgres SQL** for the database
- **Redis** for background jobs

### Core Frameworks and Libraries
- Ruby on Rails
- Tailwind CSS
- Webpacker / Shakapacker

### Notable Tools
- ViewComponent
- React
- Sidekiq
- Kramdown

### Testing and Linting
- RSpec
- Jest
- Rubocop
- Erblint
- ESLint
  
## Contributing

_Contributing guide link / more detail_

### Running the App Locally
If you've done this kind of thing before, see the guide below. You'll need to have all the preqequisites [listed here](##tech-stack) installed. Otherwise, you can find [more detailed instructions on the wiki](https://github.com/TheOdinProject/theodinproject/wiki).

#### Quickstart Guide
1. Clone this repo and `cd` to the app root
2. Copy the env sample file: `$ cp env.sample .env`
   1. Add your Postgres credentials to your `.env`
   2. Get a [GitHub API token](https://github.com/TheOdinProject/theodinproject/wiki/Running-The-Odin-Project-Locally#get-a-github-api-token) 
   and add it your `.env` in order to fetch curriculum content
3. Run `bin/setup`. If your database and GitHub token are configured correctly, this should setup and seed your database, 
   install dependencies and import content from the curriculum repo. Importing may take a few minutes, depending on your 
   connection.
4. Run `bin/test` to run all test suites and linters and ensure installation went smoothly
5. Run `bin/dev` to start the Rails server and JavaScript bundler

#### Useful Tools
##### Lookbook
In development, visit `localhost:3000/lookbook` to see a visual collection of our [ViewComponents](https://github.com/ViewComponent/view_component). See [Lookbook](https://github.com/ViewComponent/lookbook) for more info.

##### Scripts
- `bin/dev` will run all the processes you need (Rails server, JavaScript bundling and background workers) to host the app locally
- `bin/test` will run all linting checks and test suites. Useful for checking your work before making a PR
- `bin/rails db:seed` will set up courses and lessons in the database, and `bin/rails curriculum:update_content` will import it via API. Run automatically during first time setup via `bin/setup`.

## Infrastruture

- Hosting: Heroku 
- Error reporting and diagnostics: Sentry
- CDN: Searching for one

## Significant Contributors
_This should be kept, but should it be directly in the README or linked to from here?_
