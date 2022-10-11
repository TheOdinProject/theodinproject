import React from 'react';
import { func, bool, node } from 'prop-types';
import ScrollLock from 'react-scrolllock';

const modalShown = 'fixed inset-0 bg-black bg-opacity-60 dark:bg-opacity-30 z-50 react-modal';
const modalBodyPosition = 'fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2';
const modalBodySyle = 'h-auto p-10 rounded-xl bg-white dark:bg-gray-800 w-11/12 sm:w-4/5 md:w-3/5 lg:w-2/5';
const modalCloseBtn = `
  absolute inline
  top-4 right-4 m-0 p-0 border-0
  bg-transparent
  text-gray-500 hover:text-gray-700 text-xl dark:text-gray-400 dark:hover:text-gray-200
  cursor-pointer
`;

const Modal = ({ handleClose, show, children }) => {
  const showHideClassName = show ? modalShown : 'hidden';

  return (
    <ScrollLock isActive={show}>
      <div className={showHideClassName} aria-label={show ? 'modal--shown' : 'modal--hidden'}>
        <div className={`${modalBodyPosition} ${modalBodySyle}`}>
          <button
            className={modalCloseBtn}
            onClick={handleClose}
            type="button"
            aria-label="close"
          >
            <i className="fas fa-times" />
          </button>
          {show && children}
        </div>
      </div>
    </ScrollLock>
  );
};

Modal.propTypes = {
  handleClose: func.isRequired,
  show: bool.isRequired,
  children: node.isRequired,
};

export default Modal;
