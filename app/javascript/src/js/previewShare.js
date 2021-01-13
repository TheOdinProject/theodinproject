function generateLink(content) {
  // concatenating the host and pathname avoids issues if someone shares an updated preview link
<<<<<<< HEAD
  return `${window.location.host}${window.location.pathname}?content=${encodeURIComponent(content)}`;
=======
  return `${window.location.host}${window.location.pathname}?content=${content}`;
>>>>>>> master
}

function encodeContent(content) {
  return window.btoa(content);
}

function decodeContent(content) {
  const decodedContent = window.atob(content);
  return decodedContent;
}

export { generateLink, encodeContent, decodeContent };
