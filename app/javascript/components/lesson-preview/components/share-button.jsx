import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import axios from '../../../src/js/axiosWithCsrf';

const ShareButton = ({ content }) => {
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    if (copied) {
      setTimeout(() => setCopied(false), 4000);
    }
  }, [copied]);

  const handleOnClick = async () => {
    const response = await axios.post('/lessons/preview', { content });
    const previewLink = response.data.preview_link;
    navigator.clipboard.writeText(previewLink).then(() => setCopied(true));
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
