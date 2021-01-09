import React, { useState, useEffect } from 'react';
import {
  Tab, Tabs, TabList, TabPanel,
} from 'react-tabs';
import Prism from 'prismjs';

import LessonContentInput from './components/lesson-content-input';
import LessonContentPreview from './components/lesson-content-preview';
import axios from '../../src/js/axiosWithCsrf';

import 'react-tabs/style/react-tabs.css';

import { generateLink, decodeLink } from '../../src/js/mdPreviewShare';

const LessonPreview = () => {
  const [content, setContent] = useState('');
  const [convertedContent, setConvertedContent] = useState('');

  const fetchLessonPreview = async () => {
    const response = await axios.post('/lessons/preview', { content });

    if (response.status === 200) {
      setConvertedContent(response.data.content);
    }
  };

  const showModal = () => {
    console.log('copied!');
  };

  const handleClick = () => {
    const link = generateLink(content);
    navigator.clipboard.writeText(link).then(() => showModal());
  };

  useEffect(() => {
    Prism.highlightAll();
  }, [convertedContent]);

  useEffect(() => {
    const query = window.location.search;
    if (query) {
      const encodedContent = new URLSearchParams(query).get('content');
      setContent(decodeLink(encodedContent));
    }
  });

  return (
    <Tabs>
      <TabList>
        <Tab>Write</Tab>
        <Tab onClick={fetchLessonPreview}>Preview</Tab>
      </TabList>

      <TabPanel>
        <LessonContentInput onChange={setContent} content={content} />
      </TabPanel>
      <TabPanel>
        <LessonContentPreview content={convertedContent} />
      </TabPanel>
      <button type="button" className="btn-camel" onClick={handleClick}>
        Share
      </button>
    </Tabs>
  );
};

export default LessonPreview;
