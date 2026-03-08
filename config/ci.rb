# Run using bin/ci

CI.run do
  # TODO: Consider adding bin/setup

  step 'Style: Ruby', 'bin/rubocop'
  step 'Style: ERB', 'bin/erb_lint --lint-all'
  step 'Style: Standard JS', 'bin/yarn lint'
  step 'Style: Stylelint CSS', 'bin/yarn run stylelint'

  step 'Security: Gem audit', 'bin/bundler-audit'
  step 'Security: NPM audit', 'bin/yarn npm audit'
  step 'Security: Brakeman code analysis', 'bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error'

  step 'Tests: Rails', 'bin/rails spec:fast'
  step 'Tests: System', 'bin/rails spec:system'
end
