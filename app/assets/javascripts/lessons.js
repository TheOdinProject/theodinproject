var markerClasses = [
  'primary',
  'coffee',
  'whitish-grey',
  'light-grey',
  'greyish-brown'
];

function getElements(selector) {
  return document.querySelectorAll(selector);
}

function navigationElement(markerClass, headingText) {
  return (
    `<div class="lesson-navigation__element">
      <div class="lesson-navigation__marker lesson-navigation__marker--${markerClass}"></div>
      <div class="line"></div>
      <div class="lesson-navigation__title">${headingText}</div>
    </div>`
  );
}

function lessonNavigationLinks(headings) {
  return headings.map(function (heading, index) {
    var markerClass = markerClasses[index % markerClasses.length];
    return navigationElement(markerClass, heading);
  }).join('');
}

function setTargetForExternalLinks() {
  getElements('.lesson-content a[href^=http]').forEach(function (externalLink) {
    externalLink.setAttribute('target', '_blank');
  });
}

function constructLessonNavigation() {
  var headingElements = getElements('.lesson-content h3');
  var headings = Array.prototype.slice.call(headingElements).map(function(heading) {
    return heading.innerText;
  });

  var lessonNavigationLinksHTML = lessonNavigationLinks(headings);
  console.log(lessonNavigationLinksHTML);
  document.querySelector('.lesson-navigation').innerHTML = lessonNavigationLinksHTML;
}

document.addEventListener('turbolinks:load', function() {
  setTargetForExternalLinks();
  constructLessonNavigation();
});
