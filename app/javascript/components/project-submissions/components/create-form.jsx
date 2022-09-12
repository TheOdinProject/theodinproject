import React, { useContext, useState } from 'react';
import { useForm } from 'react-hook-form';
import PropTypes from 'prop-types';
import { yupResolver } from '@hookform/resolvers/yup';

import schema from '../schemas/project-submission-schema';
import ProjectSubmissionContext from '../ProjectSubmissionContext';
import Toggle from './form/toggle';
import UrlField from './form/url-field';

const CreateForm = ({ onClose, onSubmit }) => {
  const [isToggled, setIsToggled] = useState(true);
  const { lesson } = useContext(ProjectSubmissionContext);
  const {
    register,
    handleSubmit,
    formState,
  } = useForm({
    resolver: yupResolver(schema),
    defaultValues: {
      is_public: isToggled,
    },
  });

  const handleOnClickToggle = () => {
    setIsToggled(!isToggled);
  };

  const handleSubmitCallback = async (data) => (
    onSubmit({ ...data, is_public: isToggled })
  );

  const {
    errors,
  } = formState;

  if (formState.isSubmitSuccessful) {
    return (
      <div className="text-center">
        <h1 className="page-heading-title" data-test-id="success-message">Thanks for Submitting Your Solution!</h1>
        <button
          type="button"
          className="button button--primary"
          onClick={onClose}
          data-test-id="close-btn"
        >
          Close
        </button>
      </div>
    );
  }

  return (
    <div>
      <h1 className="text-center page-heading-title">Upload Your Project</h1>

      <form className="form" onSubmit={handleSubmit(handleSubmitCallback)}>
        <div className="flex flex-col space-y-4">
          <UrlField
            name="repo_url"
            label="Github repository url"
            icon="fab fa-github"
            placeholder="https://www.github.com"
            register={register}
            errors={errors}
            autoFocus
          />

          { lesson.has_live_preview && (
            <UrlField
              name="live_preview_url"
              label="Live preview url"
              icon="fas fa-link"
              placeholder="https://www.example.com"
              register={register}
              errors={errors}
            />
          )}
        </div>

        <div className="form-section form-section-center pt-8 lg:flex-row lg:justify-center mb-0">
          <Toggle label="MAKE SOLUTION PUBLIC" onClick={handleOnClickToggle} isToggled={isToggled} />

          <button
            disabled={formState.isSubmitting}
            type="submit"
            className="button button--primary"
            data-test-id="submit-btn"
          >
            Submit
          </button>
        </div>
      </form>
    </div>
  );
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
