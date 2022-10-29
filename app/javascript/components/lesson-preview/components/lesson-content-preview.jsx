/* eslint react/no-danger: 0 */
import React from 'react';
import PropTypes from 'prop-types';

const LessonContentInput = ({ content }) => (
  <div className="lesson-content max-w-none mx-auto xl:mx-0 prose prose-lg prose-gray prose-a:text-gold-600 dark:prose-code:bg-gray-700/60 dark:prose-pre:prose-code break-words line-numbers dark:prose-invert dark:antialiased min-h-screen">
    <div dangerouslySetInnerHTML={{ __html: content }} />
  </div>
);

LessonContentInput.defaultProps = {
  content: '',
};

LessonContentInput.propTypes = {
  content: PropTypes.string,
};

export default LessonContentInput;
