import React from 'react';
import PropTypes from 'prop-types';

const LessonContentInput = ({ onChange, content }) => {
  const handleOnChange = (event) => {
    onChange(event.target.value);
  };

  return (
    <textarea
      className="lesson-preview__input form-element form__element"
      placeholder="Lesson content..."
      onChange={handleOnChange}
      value={content}
    />
  );
};

LessonContentInput.defaultProps = {
  content: '',
};

LessonContentInput.propTypes = {
  onChange: PropTypes.func.isRequired,
  content: PropTypes.string,
};

export default LessonContentInput;
