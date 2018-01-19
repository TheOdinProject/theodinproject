document.addEventListener('turbolinks:load', function() {
  const floatingMenu = document.querySelector('.floating-dropdown');
  const chatFloatingMenu = document.querySelector('.forum-floating-btn');
  const forumFloatingMenu = document.querySelector('.chat-floating-btn');

  floatingMenu.addEventListener('mouseover', function() {
    chatFloatingMenu.className += ' floating-btn-show';
    forumFloatingMenu.className += ' floating-btn-show';
  });

  floatingMenu.addEventListener('mouseout', function() {
    chatFloatingMenu.classList.remove('floating-btn-show');
    forumFloatingMenu.classList.remove('floating-btn-show');
  });
});
