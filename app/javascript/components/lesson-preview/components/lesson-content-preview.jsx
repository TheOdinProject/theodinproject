/* eslint react/no-danger: 0 */
import React from 'react';
import PropTypes from 'prop-types';

const LessonContentInput = ({ content }) => (
  <div className="lesson-content prose prose-lg prose-slate prose-a:text-gold-600 min-h-screen max-w-prose mx-auto"><div dangerouslySetInnerHTML={{ __html: content }} /></div>
);

LessonContentInput.defaultProps = {
  content: '',
};

LessonContentInput.propTypes = {
  content: PropTypes.string,
};

export default LessonContentInput;
