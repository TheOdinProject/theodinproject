import React, { useState, useMemo, useContext } from 'react';
import { object, func, bool } from 'prop-types';
import axios from '../../../src/js/axiosWithCsrf';

import Modal from './modal';
import EditForm from './edit-form';
import ProjectSubmissionContext from '../ProjectSubmissionContext';
import SubmissionTitle from './submission-title';

const noop = () => {}

const Submission = ({ submission, handleUpdate, onFlag, handleDelete, isDashboardView }) => {
  const { userId } = useContext(ProjectSubmissionContext);
  const [showEditModal, setShowEditModal] = useState(false);
  const isCurrentUsersSubmission = useMemo(() =>
    userId === submission.user_id, [userId, submission.user_id]);

  const toggleShowEditModal = () => setShowEditModal(prevShowEditModal => !prevShowEditModal);
  const livePreview = submission.live_preview_url.length > 0;

  console.log(submission);

  const likeSubmission = async (submissionId) => {
    const response = await axios.post(
      `/project_submissions/${submissionId}/likes`,
      {
        submission_id: submissionId,
      }
    );

    if (response.status === 200) {
      return true;
    } else {
      return false;
    }
  };

  return (
    <div className="submissions__item">
      <p className="submissions__submission-title">
        <SubmissionTitle submission={submission} isDashboardView={isDashboardView} />
      </p>

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
        { livePreview &&
          <a href={submission.live_preview_url} target="_blank" className="submissions__button">Live Preview</a>
        }

        {!isCurrentUsersSubmission
          ? 
          <a className='submissions__like hint--top' aria-label='Like submission' onClick={(event) => {
            event.preventDefault(); 
            const res = likeSubmission(submission.id);
            
            if (res) event.target.classList.add('liked');
          }
          }>
            <i className='fa fa-heart'></i>
          </a> 
          : ''
        }

        {isCurrentUsersSubmission
          ? <span className={`submissions__public-icon submissions__public-icon${submission.is_public ? '--visible' : ''}`}><i className="fas fa-eye"></i></span>
          :               
          <a className='submissions__flag hint--top' aria-label='Report submission' onClick={(event) => { event.preventDefault(); onFlag(submission)}}>
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
  isDashboardView: bool,
};

export default Submission;
