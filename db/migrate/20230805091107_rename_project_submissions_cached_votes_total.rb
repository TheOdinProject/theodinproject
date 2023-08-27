class RenameProjectSubmissionsCachedVotesTotal < ActiveRecord::Migration[7.0]
  def change
    rename_column :project_submissions, :cached_votes_total, :likes_count
  end
end
