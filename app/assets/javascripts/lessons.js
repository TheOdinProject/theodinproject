var LESSON_HEADINGS = [
  'Overview',
  'Learning Outcomes',
  'Assignment',
  'Additional Resources'
];

function getElements(selector) {
  return document.querySelectorAll(selector);
}

function kebabCase(text) {
  return text.toLowerCase().match(/\w+/g).join('-');
}

function setTargetForExternalLinks() {
  getElements('.lesson-content a[href^=http]').forEach(function (externalLink) {
    externalLink.setAttribute('target', '_blank');
  });
}

function navigationElement(headingText) {
  return (
    '<div class="lesson-navigation__item">' +
    '<div class="lesson-navigation__circle"></div>' +
    '<div class="lesson-navigation__title">' +
    '<a class="grey" href="#' + kebabCase(headingText) + '" data-turbolinks="false">' + headingText +
    '</a></div></div>'
  );
}

function lessonNavigation(headings) {
  return headings.map(navigationElement).join('');
}

function getInnerText(heading) {
  return heading.innerText;
}

function isCommonHeading(heading) {
  return LESSON_HEADINGS.indexOf(heading) !== -1;
}

function getLessonHeadings() {
  var headingElements = getElements('.lesson-content h3');

  return Array.prototype.slice.call(headingElements)
  .map(getInnerText)
  .filter(isCommonHeading);
}

function constructLessonNavigation() {
  var commonHeadings = getLessonHeadings();
  if (commonHeadings.length === 0) return;

  var lessonNavigationHTML = lessonNavigation(commonHeadings);
  var lessonNavigationElement = document.querySelector('.lesson-navigation');
  lessonNavigationElement.innerHTML = lessonNavigationHTML;
  Stickyfill.add(lessonNavigationElement);
}

function lessonPage() {
  return document.querySelector('.lesson') !== null;
}

document.addEventListener('turbolinks:load', function() {
  if (!lessonPage()) return;

  setTargetForExternalLinks();
  constructLessonNavigation();
});
