import * as React from 'react';
import { Route, Switch } from 'react-router-dom';

import { Main } from './screens/main';
import { NotFound } from './screens/not-found';

export const AppRoutes = () => (
    <Switch>
      <Route exact path="/" component={Main} />
      <Route path="*" component={NotFound} />
    </Switch>
);
