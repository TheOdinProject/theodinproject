import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import {
  Tab, Tabs, TabList, TabPanel,
} from 'react-tabs';
import Prism from 'prismjs';

import LessonContentInput from './components/lesson-content-input';
import LessonContentPreview from './components/lesson-content-preview';
import ShareButton from './components/share-button';
import axios from '../../src/js/axiosWithCsrf';

const LessonPreview = ({previewContent}) => {
  const [content, setContent] = useState(previewContent);
  const [convertedContent, setConvertedContent] = useState('');
  const [copied, setCopied] = useState(false);
  const [link, setLink] = useState(window.location.href);
  const [onPreviewTab, setOnPreviewTab] = useState(false);

  const fetchLessonPreview = async () => {
    if (onPreviewTab) return;

    const response = await axios.post('/lessons/preview/markdown', { content });

    if (response.status === 200) {
      setConvertedContent(response.data.content);
      setOnPreviewTab(true);
      Prism.highlightAll();
    }
  };

  const handleShareClick = async () => {
    const response = await axios.post('/lessons/preview', { content });
    const previewLink = response.data.preview_link;
    navigator.clipboard.writeText(previewLink).then(() => setCopied(true));
  };

  useEffect(() => {
    const query = window.location.search;
    if (query) {
      setContent(previewContent);
    }
  }, []);

  useEffect(() => {
    if (copied) {
      setTimeout(() => setCopied(false), 4000);
    }
  }, [copied]);

  return (
    <Tabs selectedTabClassName="text-gray-700 bg-gray-300/50 hover:bg-gray-300 dark:bg-gray-700/90 dark:text-gray-300">
      <TabList className="flex items-center mb-3">
        <Tab onClick={() => setOnPreviewTab(false)} className="text-gray-600 hover:text-gray-800 bg-gray-50 hover:bg-gray-200 dark:bg-gray-700/40 dark:text-gray-300 rounded-md border border-transparent px-3 py-1.5 font-medium cursor-pointer focus:outline-none">Write</Tab>
        <Tab onClick={fetchLessonPreview} className="ml-2 text-gray-600 hover:text-gray-800 bg-gray-50 hover:bg-gray-200 dark:bg-gray-700/40 dark:text-gray-300 rounded-md border border-transparent px-3 py-1.5 font-medium cursor-pointer focus:outline-none">Preview</Tab>
      </TabList>

      <TabPanel>
        <LessonContentInput onChange={setContent} content={content} />
      </TabPanel>
      <TabPanel>
        <LessonContentPreview content={convertedContent} />
      </TabPanel>
      <div className='flex pt-10 justify-end'>
        <ShareButton text={copied ? 'Copied!' : 'Share'} classes={copied ? 'button--secondary' : 'button--primary'} onClick={handleShareClick}>
        </ShareButton>
      </div>
    </Tabs>
  );
};

LessonPreview.defaultProps = {
  previewContent: ''
};

LessonPreview.propTypes = {
  previewContent: PropTypes.string
};

export default LessonPreview;
