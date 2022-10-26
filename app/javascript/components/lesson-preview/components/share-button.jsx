import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import axios from '../../../src/js/axiosWithCsrf';

const ShareButton = ({text, classes, onClick}) => {
  const [copied, setCopied] = useState(false);

  const handleOnClick = (event) => {
    onClick(event.target.value);
  };

  return (
    <button type="button" className={`button ${classes}`} onClick={handleOnClick} >
      {text}
    </button >
  )
}

ShareButton.defaultProps = {
  text: 'Share',
  classes: "button-primary"
};

ShareButton.propTypes = {
  content: PropTypes.string,
  classes: PropTypes.string,
  onClick: PropTypes.func.isRequired,
};

export default ShareButton;
