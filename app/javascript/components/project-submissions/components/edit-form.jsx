import React, { useState } from 'react';
import { useForm } from 'react-hook-form';
import { func, object } from 'prop-types';
import { yupResolver } from '@hookform/resolvers/yup';

import schema from '../schemas/project-submission-schema';
import Toggle from './form/toggle';
import UrlField from './form/url-field';

const EditForm = ({
  submission, onSubmit, onClose, onDelete,
}) => {
  const [isToggled, setIsToggled] = useState(submission.is_public);
  const {
    register,
    handleSubmit,
    formState,
  } = useForm({
    resolver: yupResolver(schema),
    defaultValues: {
      repo_url: submission.repo_url,
      live_preview_url: submission.live_preview_url,
      is_public: submission.is_public,
    },
  });

  const { errors } = formState;

  const handleOnClickToggle = () => {
    setIsToggled(!isToggled);
  };

  const handleDelete = () => {
    onDelete(submission.id);
    onClose();
  };

  const handleSubmitCallback = async (data) => (
    onSubmit({ ...data, is_public: isToggled })
  );

  if (formState.isSubmitSuccessful) {
    return (
      <div className="text-center">
        <h1 className="page-heading-title">Thanks for Updating Your Solution!</h1>
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
    <div data-test-id="edit-form">
      <h1 className="text-center page-heading-title">Edit Your Project</h1>

      <form className="form" onSubmit={handleSubmit(handleSubmitCallback)}>
        <input type="hidden" {...register('id')} value={submission.id} />
        <input type="hidden" {...register('lesson_id')} value={submission.lesson_id} />

        <div className="flex flex-col space-y-4">
          <UrlField
            name="repo_url"
            label="Github repository url"
            icon="fab fa-github"
            placeholder="https://github.com"
            register={register}
            errors={errors}
            autoFocus
          />

          { submission.lesson_has_live_preview && (
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

        <div className="form-section form-section-center mb-0">
          <Toggle label="MAKE SOLUTION PUBLIC" onClick={handleOnClickToggle} isToggled={isToggled} />

          <div className="flex flex-col items-center sm:flex-row sm:justify-center">
            <button
              type="submit"
              className="button button--danger sm:mr-2"
              onClick={handleDelete}
              data-test-id="delete-btn"
            >
              Delete
            </button>
            <button
              disabled={formState.isSubmitting}
              type="submit"
              className="button button--primary mt-2 sm:mt-0"
              data-test-id="submit-btn"
            >
              Update
            </button>
          </div>
        </div>
      </form>
    </div>
  );
};

EditForm.propTypes = {
  submission: object.isRequired,
  onSubmit: func.isRequired,
  onClose: func.isRequired,
  onDelete: func.isRequired,
};

export default EditForm;
