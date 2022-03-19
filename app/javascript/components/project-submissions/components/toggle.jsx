/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import PropTypes from 'prop-types';

const toggleContainerClassNames = `
  relative inline-flex flex-shrink-0
  h-6 w-12 py-2px
  border-2 border-transparent rounded-full
  cursor-pointer
  transition-colors ease-in-out duration-200
  focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-odin-green
`;
const toggleBodyClassNames = `
  inline-block
  h-5 w-5
  pointer-events-none
  rounded-full bg-white shadow
  transform ring-0 transition ease-in-out duration-200
`;

/**
 * react-hook-form's register does not apply to buttons, which is the root element of Tailwind's
 * toggle. We must therefore pass it's "value" between form parent component and Toggle, thereby
 * allowing us to add it into the form data.
 */
const Toggle = ({ label, isToggled, onClick }) => (
  <>
    <p className="font-bold">{label}</p>
    <div className="my-0 mx-4" data-test-id="is-public-toggle-slider">
      <button
        id="is_public"
        type="button"
        onClick={onClick}
        className={`${toggleContainerClassNames} ${isToggled ? 'bg-odin-green' : 'bg-gray-200'}`}
        role="switch"
        aria-checked={isToggled}
      >
        <span className="sr-only">{label}</span>
        <span
          aria-hidden="true"
          className={`${toggleBodyClassNames} ${isToggled ? 'translate-x-7' : 'translate-x-0'}`}
        />
      </button>
    </div>
  </>
);

Toggle.defaultProps = {
  label: undefined,
};

Toggle.propTypes = {
  label: PropTypes.string,
  isToggled: PropTypes.bool.isRequired,
  onClick: PropTypes.func.isRequired,
};

export default Toggle;
