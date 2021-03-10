import React, { Component } from 'react';
import { Routes } from '@';
import { Header, Footer } from '@components'

class AppComponent extends Component {
  render() {
    return (
      <div className="app">
        <Header />
        <Routes />
        <Footer />
      </div>
    );
  }
}

export const modifiedApp = AppComponent;