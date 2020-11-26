import { fireEvent, render } from '@testing-library/react';
import React from 'react';
import ProjectSubmissionContext from '../../ProjectSubmissionContext';
import Like from '../like';

describe('Like', () => {
  const renderLikeComponent = (userId = null, isLikedByUser = false, handleClick = () => {}) => {
    return render(
      <ProjectSubmissionContext.Provider value={{ userId }}>
        <Like 
          submission={{ is_liked_by_current_user: isLikedByUser }} 
          handleLikeToggle={handleClick}
        />;
      </ProjectSubmissionContext.Provider>
    )
  }

  test('Tells user to log in to like submission', () => {
    const { queryByLabelText, getByLabelText } = renderLikeComponent();

    const anchorNode = queryByLabelText('Log in to like!');
    const iconNode = getByLabelText('Like icon');

    expect(anchorNode).toBeTruthy();
    expect(iconNode).not.toHaveClass('liked');
  })

  test('Indicates user can like submission', () => {
    const { queryByLabelText, getByLabelText } = renderLikeComponent(1, false);

    const anchorNode = queryByLabelText('Like submission');
    const iconNode = getByLabelText('Like icon');

    expect(anchorNode).toBeTruthy();
    expect(iconNode).not.toHaveClass('liked');
  })


  test('Indicates user has liked submission', () => {
    const { queryByLabelText, getByLabelText } = renderLikeComponent(1, true);

    const anchorNode = queryByLabelText('Unlike submission');
    const iconNode = getByLabelText('Like icon');

    expect(anchorNode).toBeTruthy();
    expect(iconNode).toHaveClass('liked');
  })

  test('Calls toggle like handler when clicked', () => {
    const handleClick = jest.fn();
    const { getByLabelText } = renderLikeComponent(null, false, handleClick);
    const anchorNode = getByLabelText(/like/);
    fireEvent.click(anchorNode);

    expect(handleClick).toHaveBeenCalledTimes(1);
  })

})