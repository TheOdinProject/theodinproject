import React from 'react';
import { object, func } from 'prop-types';

const VisibleToggle = ({ submission, handleVisibleToggle }) => {
  return (
    <a
      onClick={() => handleVisibleToggle(submission.repo_url, submission.live_preview_url, !submission.is_public, submission.id)}
      className={`submissions__public-icon submissions__public-icon${submission.is_public ? '--visible hint--top' : ' hint--top'}`}
      aria-label='Toggle visibility'>
      <i className="fas fa-eye"></i>
    </a>
  );
};

VisibleToggle.propTypes = {
  submission: object.isRequired,
  handleVisibleToggle: func,
}

export default VisibleToggle;
