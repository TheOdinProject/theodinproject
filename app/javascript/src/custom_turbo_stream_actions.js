import { Turbo } from '@hotwired/turbo-rails';


Turbo.StreamActions.toggle_classes = function toggleClasses() {
  const cssClasses = this.getAttribute('classes').split(' ');
  const id = this.getAttribute('id');
  const element = document.getElementById(id);

  cssClasses.forEach((cssClass) => {
    element.classList.toggle(cssClass);
  });
};
