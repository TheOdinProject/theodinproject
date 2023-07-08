/* eslint react/no-danger: 0 */
import React from 'react';
import PropTypes from 'prop-types';

const LessonContentInput = ({ content }) => (
  // eslint-disable-next-line max-len
  <div className="lesson-content max-w-prose mx-auto prose md:prose-lg prose-gray prose-a:text-blue-800 visited:prose-a:text-purple-800 dark:prose-a:text-blue-300 dark:visited:prose-a:text-purple-300 prose-code:bg-gray-100 prose-code:p-1 prose-code:font-normal  dark:prose-code:bg-gray-700/40 prose-code:rounded-md break-words line-numbers dark:prose-invert dark:antialiased prose-pre:rounded-xl prose-pre:bg-slate-800 prose-pre:shadow-lg dark:prose-pre:bg-slate-800/70 dark:prose-pre:shadow-none dark:prose-pre:ring-1 dark:prose-pre:ring-slate-300/10">
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
