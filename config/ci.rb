# Run using bin/ci

CI.run do
  # step 'Setup', 'bin/setup --skip-server' # TODO: Needs some tweaking to run

  step 'Style: Ruby', 'bin/rubocop'
  step 'Style: ERB',  'bin/erb_lint --lint-all'
  step 'Style: JS', 'yarn lint'
  step 'Style: CSS', 'yarn run stylelint'

  step 'Security: Gem audit', 'bin/bundler-audit'
  # TODO: Swap to --exit-on-warn --exit-on-error once issues are resolved
  step 'Security: Brakeman code analysis', 'bin/brakeman --quiet --no-pager --no-exit-on-warn --no-exit-on-error'

  step 'Tests: Rails', 'bin/rspec --tag ~type:system'
  step 'Tests: System', 'bin/rails spec:system'
  # step 'Tests: Seeds', 'env RAILS_ENV=test bin/rails db:seed:replant' # TODO: Needs some tweaking to run

  # Optional: set a green GitHub commit status to unblock PR merge.
  # Requires the `gh` CLI and `gh extension install basecamp/gh-signoff`.
  # if success?
  #   step "Signoff: All systems go. Ready for merge and deploy.", "gh signoff"
  # else
  #   failure "Signoff: CI failed. Do not merge or deploy.", "Fix the issues and try again."
  # end
end
