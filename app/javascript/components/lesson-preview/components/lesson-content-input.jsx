import React from 'react';
import PropTypes from 'prop-types';

const LessonContentInput = ({ onChange, content }) => {
  const handleOnChange = (event) => {
    onChange(event.target.value);
  };

  return (
    <textarea
      className="w-full min-h-screen block rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 dark-form-input"
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
