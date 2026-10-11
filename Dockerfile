FROM ruby:3.4.6
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
WORKDIR /home/user
RUN echo -e "#!/bin/bash\nrails db:create && rails db:environment:set RAILS_ENV=development && rails db:schema:load && rails db:seed && rails curriculum:update_content" >> /usr/bin/load \
    && chmod +x /usr/bin/load \
    && echo -e "#!/bin/bash\nrails curriculum:update_content" >> /usr/bin/update \
    && chmod +x /usr/bin/update

COPY .yarn .yarn
COPY package.json yarn.lock .yarnrc.yml .node-version ./
ENV BASH_ENV "${HOME}/.bash_env"
RUN touch "${BASH_ENV}" && echo '. "${BASH_ENV}"' >> ~/.bashrc && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | PROFILE="${BASH_ENV}" bash
RUN echo node > .nvmrc && nvm install 24 && npm install --global yarn && yarn install

COPY Gemfile Gemfile.lock .ruby-version ./
RUN gem install bundler:2.7.1 foreman && bundle install

CMD bin/dev
