import React from 'react';
import { render } from 'react-dom';
import { BrowserRouter } from "react-router-dom";
import { App } from '../src';

export const mount = MountApp =>
  render(
    <BrowserRouter>
      <MountApp />
    </BrowserRouter>,
    document.getElementById('_root')
  );

document.addEventListener("DOMContentLoaded", () => mount(App));
