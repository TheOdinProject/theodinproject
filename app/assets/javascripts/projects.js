$(document).on('turbolinks:load', function() {
  $('body').on('shown.bs.modal', '#project-submission-modal', function() {
    $('#project_repo_url').focus();
  });

  $('body').on('show.bs.modal', '#delete-project-modal', function() {
    $('#project-submission-modal').modal('hide');
  });
});
