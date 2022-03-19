import React, { useContext, useState } from 'react';
import { useForm } from 'react-hook-form';
import PropTypes from 'prop-types';
import { yupResolver } from '@hookform/resolvers/yup';

import schema from '../schemas/project-submission-schema';
import ProjectSubmissionContext from '../ProjectSubmissionContext';

const darkModeCSSClassNames = 'form__element form__element--with-icon dark-form-input';
const toggleContainerClassNames = `
  relative inline-flex flex-shrink-0
  h-6 w-12 py-2px
  border-2 border-transparent rounded-full
  cursor-pointer
  transition-colors ease-in-out duration-200
  focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-odin-green
`;
const toggleBodyClassNames = `
  inline-block
  h-5 w-5
  pointer-events-none
  rounded-full bg-white shadow
  transform ring-0 transition ease-in-out duration-200
`;

const CreateForm = ({ onClose, onSubmit, userId }) => {
  const [isToggled, setIsToggled] = useState(false);
  const { lesson } = useContext(ProjectSubmissionContext);
  const {
    register,
    handleSubmit,
    formState,
  } = useForm({
    resolver: yupResolver(schema),
    defaultValues: {
      is_public: true,
    },
  });

  const handleOnClickToggle = () => {
    setIsToggled(!isToggled);
  };

  const {
    errors,
  } = formState;

  if (formState.isSubmitSuccessful) {
    return (
      <div className="text-center">
        <h1 className="page-heading-title" data-test-id="success-message">Thanks for Submitting Your Solution!</h1>
        <button
          type="button"
          className="top-btn top-btn-primary"
          onClick={onClose}
          data-test-id="close-btn"
        >
          Close
        </button>
      </div>
    );
  }

  /* eslint-disable react/jsx-props-no-spreading */
  return (
    <div>
      <h1 className="text-center page-heading-title">Upload Your Project</h1>

      <form className="form" onSubmit={handleSubmit(onSubmit)}>
        <div className="form-section">
          <span className="form-icon fab fa-github" />
          <input
            autoFocus
            className={`form-element-with-icon ${darkModeCSSClassNames}`}
            type="url"
            {...register('repo_url')}
            placeholder="Repository URL"
            data-test-id="repo-url-field"
          />
        </div>
        {errors.repo_url && (
        <div className="form-error" data-test-id="error-message">
          {' '}
          {errors.repo_url.message}
        </div>
        )}

        { lesson.has_live_preview
          && (
          <>
            <div className="form-section">
              <span className="form-icon fas fa-link" />
              <input
                className={`form-element-with-icon ${darkModeCSSClassNames}`}
                type="url"
                placeholder="Live Preview URL"
                {...register('live_preview_url')}
                data-test-id="live-preview-url-field"
              />
            </div>
            { errors.live_preview_url && (
            <div className="form-error" data-test-id="error-message">
              {' '}
              {errors.live_preview_url.message}
            </div>
            ) }
          </>
          )}

        <div className="form-section form-section-center mb-0">
          <div className="flex items-center my-1.25rem sm:my-0 justify-center">
            <p className="font-bold">MAKE SOLUTION PUBLIC</p>
            <div className="my-0 mx-4" data-test-id="is-public-toggle-slider">
              <button
                type="button"
                onClick={handleOnClickToggle}
                className={`${toggleContainerClassNames} ${isToggled ? 'bg-odin-green' : 'bg-gray-200'}`}
                role="switch"
                aria-checked="false"
                {...register('is_public')}
              >
                <span className="sr-only">MAKE SOLUTION PUBLIC</span>
                <span
                  aria-hidden="true"
                  className={`${toggleBodyClassNames} ${isToggled ? 'translate-x-7' : 'translate-x-0'}`}
                />
              </button>
            </div>
          </div>

          <button
            disabled={formState.isSubmitting}
            type="submit"
            className="top-btn top-btn-primary"
            data-test-id="submit-btn"
          >
            Submit
          </button>
        </div>
      </form>
    </div>
  );
  /* eslint-enable react/jsx-props-no-spreading */
};

CreateForm.defaultProps = {
  userId: null,
};

CreateForm.propTypes = {
  onClose: PropTypes.func.isRequired,
  onSubmit: PropTypes.func.isRequired,
  userId: PropTypes.number,
};

export default CreateForm;
