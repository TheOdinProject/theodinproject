import React from 'react';
import { useForm } from 'react-hook-form';
import { func, object, number } from 'prop-types';

import TextArea from './form/text-area';

const FlagForm = ({ onSubmit, submission }) => {
  const {
    register, handleSubmit, formState,
  } = useForm();

  const { errors } = formState;

  if (formState.isSubmitSuccessful) {
    return (
      <div className="text-center text-3xl">
        <h2 className="bold">Thanks for helping us keep our community safe!</h2>
        <p>Our Moderators will review this issue shortly.</p>
      </div>
    );
  }

  return (
    <div>
      <h1 className="text-center page-heading-title">Flag Submission</h1>

      <form className="form" onSubmit={handleSubmit(onSubmit)}>
        <input type="hidden" value={submission.id} {...register('project_submission_id')} />
        <div className="mb-6">
          <TextArea
            name="reason"
            register={register}
            errors={errors}
            rows="5"
            placeholder="Please explain why you are flagging this submission..."
            autoFocus
            dataTestId="flag-description-field"
          />
        </div>

        <div className="form-section form-section-center">
          <button
            disabled={formState.isSubmitting}
            className="button button--primary"
            type="submit"
            data-test-id="submit-flag-btn"
          >
            Flag
          </button>
        </div>
      </form>
    </div>
  );
};

FlagForm.defaultProps = {
  userId: null,
};

FlagForm.propTypes = {
  onSubmit: func.isRequired,
  submission: object.isRequired,
  userId: number,
};

export default FlagForm;
