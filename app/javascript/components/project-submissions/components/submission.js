import React, { useState, useMemo, useContext } from 'react';
import { object, func, bool } from 'prop-types';

import Modal from './modal';
import EditForm from './edit-form';
import ProjectSubmissionContext from '../ProjectSubmissionContext';
import SubmissionTitle from './submission-title';
import Like from './like';
import VisibleToggle from './visible-toggle';

const noop = () => { }

const Submission = ({ submission, handleUpdate, onFlag, handleDelete, isDashboardView, handleLikeToggle, handleVisibleToggle }) => {
  const { userId } = useContext(ProjectSubmissionContext);
  const [showEditModal, setShowEditModal] = useState(false);
  const isCurrentUsersSubmission = useMemo(() =>
    userId === submission.user_id, [userId, submission.user_id]);

  const toggleShowEditModal = () => setShowEditModal(prevShowEditModal => !prevShowEditModal);
  const livePreview = submission.live_preview_url.length > 0;

  return (
    <div className="submissions__item">
      <div className="submissions__left-container">
        <Like submission={submission} handleLikeToggle={handleLikeToggle} />
        <p className="submissions__submission-title">
          <SubmissionTitle submission={submission} isDashboardView={isDashboardView} />
        </p>
      </div>

      <div className="submissions__actions">
        {isCurrentUsersSubmission && (
          <button
            className="submissions__button submissions__button--green"
            onClick={toggleShowEditModal}
          >
            Edit Solution
          </button>
        )}
        <a href={submission.repo_url} target="_blank" className="submissions__button">View Code</a>
        {livePreview &&
          <a href={submission.live_preview_url} target="_blank" className="submissions__button">Live Preview</a>
        }

        {isCurrentUsersSubmission
          ? <VisibleToggle submission={submission} handleVisibleToggle={handleVisibleToggle} />
          :
          <a className='submissions__flag hint--top' aria-label='Report submission' onClick={(event) => { event.preventDefault(); onFlag(submission) }}>
            <i className='fas fa-flag'></i>
          </a>
        }
      </div>

      <Modal show={showEditModal} handleClose={toggleShowEditModal}>
        <EditForm
          submission={submission}
          onSubmit={handleUpdate}
          onDelete={handleDelete}
          onClose={toggleShowEditModal}
        />
      </Modal>
    </div>
  );
};

Submission.defaultProps = {
  onFlag: noop,
  isDashboardView: false,
}

Submission.propTypes = {
  submission: object.isRequired,
  handleUpdate: func.isRequired,
  onFlag: func,
  handleDelete: func.isRequired,
  handleLikeToggle: func.isRequired,
  handleVisibleToggle: func,
  isDashboardView: bool,
};

export default Submission;
