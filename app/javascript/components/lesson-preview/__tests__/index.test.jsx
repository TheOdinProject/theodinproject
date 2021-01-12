import { fireEvent, render } from '@testing-library/react';
import React from 'react';
import LessonPreview from '../index';

describe('LessonPreview', () => {
  test('Displays Share', () => {
    const { queryByLabelText } = render(
      <LessonPreview />,
    );

    const buttonText = queryByLabelText('Share');
    expect(buttonText.textContent).toBe('Share');
  });
});
