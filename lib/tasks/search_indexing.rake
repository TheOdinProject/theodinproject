namespace :search do
  desc 'index documents for searching'
  task index: :environment do
    Rails.logger.info 'Indexing content for searching...'
    SearchIndexer.index_frequencies
  end
end
