/*
- a link generator that could encode the content into a base64 format
- append it to a query parameter for sharing.
- When another user clicks this link
, apply the text that was stored in the base64 query parameter to the body of the form
- Add a button that allows you to generate a link from the text in the form
- Load text from query parameter when page is loaded
- Unit tests for all added code */

function generateLink(content) {
  const base64 = window.btoa(content);
  return `${window.location.href}?content=${base64}`;
}

function decodeLink(content) {
  const decodedContent = window.atob(content);
  return decodedContent;
}

export { generateLink, decodeLink };
