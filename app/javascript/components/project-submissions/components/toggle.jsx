/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import PropTypes from 'prop-types';

const Toggle = ({ label, isToggled, onClick }) => (
  <>
    <p className="font-bold">{label}</p>
    <div className="my-0 mx-4" data-test-id="is-public-toggle-slider">
      <button
        id="is_public"
        type="button"
        onClick={onClick}
        className={`top-toggle-body ${isToggled ? 'bg-odin-green' : 'bg-gray-200'}`}
        role="switch"
        aria-checked={isToggled}
      >
        <span className="sr-only">{label}</span>
        <span
          aria-hidden="true"
          className={`top-toggle-span ${isToggled ? 'translate-x-6' : 'translate-x-0'}`}
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
