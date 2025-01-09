import React from 'react';
import { Link } from 'react-router-dom';
import { Button } from './Button';

const HeroSection = () => {
  return (
    <div className="hero-container">
      <Link to="/Words/Words">
        <Button
          className="btns"
          buttonStyle="btn--outline"
          buttonSize="btn--large"
        >
          시작하기
        </Button>
      </Link>
    </div>
  );
};

export default HeroSection; 