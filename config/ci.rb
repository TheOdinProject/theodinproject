# Run using bin/ci

CI.run do
  # step 'Setup', 'bin/setup --skip-server'

  step 'Style: Ruby', 'bin/rubocop'
  step 'Style: ERB',  'bin/erb_lint --lint-all'
  step 'Style: JS', 'yarn lint'
  step 'Style: CSS', 'yarn run stylelint'

  step 'Security: Brakeman code analysis', 'bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error'

  step 'Tests: Rails', 'bin/rspec --tag ~type:system'
  step 'Tests: System', 'bin/rails spec:system'
  # step 'Tests: Seeds', 'env RAILS_ENV=test bin/rails db:seed:replant'

  # Optional: set a green GitHub commit status to unblock PR merge.
  # Requires the `gh` CLI and `gh extension install basecamp/gh-signoff`.
  # if success?
  #   step "Signoff: All systems go. Ready for merge and deploy.", "gh signoff"
  # else
  #   failure "Signoff: CI failed. Do not merge or deploy.", "Fix the issues and try again."
  # end
end
