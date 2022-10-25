import React from 'react';
import PropTypes from 'prop-types';

const ShareButton = ({content, classes}) => {

  const handleClick = async () => {
    const response = await axios.post('/lessons/preview', {content});
    const previewLink = response.data.preview_link;

    navigator.clipboard.writeText(previewLink).then(() => setCopied(true));
  };

  return (
    <button type="button" className={`button ${classes}`} onClick={handleClick} >
      {content}
    </button >
  )
}

ShareButton.defaultProps = {
  content: 'Share',
  classes: "button-primary"
};

ShareButton.propTypes = {
  content: PropTypes.string,
  classes: PropTypes.string,
};

export default ShareButton;
