$(document).on('turbolinks:load', function() {
  $('#project-submission-modal').on('shown.bs.modal', function() {
    $('#project_repo_url').focus();
  });
});
