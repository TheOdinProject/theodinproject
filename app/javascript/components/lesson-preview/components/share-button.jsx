import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import axios from '../../../src/js/axiosWithCsrf';

const ShareButton = ({ content }) => {
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    if (copied) {
      setCopied(false);
    }
  }, [content]);

  /**
   * Helper method to get the name of the browser we are using. The conditional tree's
   * order matters since some UserAgent strings are included in the same browsers.
   * 
   * The reason we care about the specific browser is because the Clipboard
   * API's implementation across browser's is inconsistent. For example, ClipboardItem
   * is not available on Firefox. Chrome will complain about the MIME type.
   * @returns A string of a relevant browser name, or undefined.
   */
  const getBrowserName = () => {
    if(navigator.userAgent.indexOf("Firefox") !== -1)
      return "Firefox";
    else if(navigator.userAgent.indexOf("Chrome") !== -1)
      return "Chrome";
    else if(navigator.userAgent.indexOf("Safari") !== -1)
      return "Safari";
    
    return undefined;   
}

  const getPreviewLink = async () => {
    const response = await axios.post('/lessons/preview', { content });
    return response.data.preview_link;
  }

  const handleOnClick = async () => {
    const browserName = getBrowserName();
    
    if (browserName === 'Safari') {
      navigator.clipboard.write([new ClipboardItem({ "text/plain": getPreviewLink() })])
        .then(() => setCopied(true));
    } else {
      navigator.clipboard.writeText(await getPreviewLink()).then(() => setCopied(true));
    }
  };

  return (
    <button
      className={`button ${copied ? 'button--secondary' : 'button--primary'}`}
      onClick={handleOnClick}
      type="button"
    >
      {copied ? 'Copied!' : 'Share'}
    </button>
  );
};

ShareButton.defaultProps = {
  content: '',
};

ShareButton.propTypes = {
  content: PropTypes.string,
};

export default ShareButton;
