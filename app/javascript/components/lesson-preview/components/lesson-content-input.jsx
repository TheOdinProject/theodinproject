import React from 'react';
import PropTypes from 'prop-types';

const LessonContentInput = ({ onChange, content }) => {
  const handleOnChange = (event) => {
    onChange(event.target.value);
  };

  return (
    <textarea
      className="w-full min-h-screen block rounded-md border-slate-300 dark:bg-slate-700 dark:focus:ring-2 dark:placeholder-slate-400 dark:border-slate-500 dark:focus:ring-slate-500 shadow-sm focus:border-blue-500 focus:ring-blue-500 dark-form-input"
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
