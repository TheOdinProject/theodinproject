# Allows an example group to opt out of transactional fixtures via the
# `:non_transactional` metadata tag, so that `after_commit` callbacks (e.g. Turbo
# Stream broadcasts) actually fire. Overriding `run_in_transaction?` is the hook
# rspec-rails itself uses to decide whether to wrap the example in a transaction.
# Records created during the example are removed afterwards by truncating the tables.
module NonTransactional
  def run_in_transaction?
    return false if RSpec.current_example&.metadata&.[](:non_transactional)

    super
  end
end

RSpec.configure do |config|
  config.prepend NonTransactional

  config.append_after(:each, :non_transactional) do
    connection = ActiveRecord::Base.connection
    tables = connection.tables - %w[ar_internal_metadata schema_migrations]
    table_list = tables.map { connection.quote_table_name(it) }.join(', ')
    connection.execute("TRUNCATE #{table_list} RESTART IDENTITY CASCADE")
  end
end
