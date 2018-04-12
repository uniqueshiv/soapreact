import React ,{Component} from 'react';
import {Router, Route, Link } from 'react-router-dom'
import Home from './Home';
import Navbar from './Navbar';
import About from './About';
import Contact from './Contact';


import createBrowserHistory from 'history/createBrowserHistory';

const customHistory=createBrowserHistory();



const customRoutes=()=>(
  <Router history={customHistory}>
    <div>
      <Navbar />
      <hr />
      <Route exact  path='/' component={Home} />
      <Route exact path='/about' component={About} />
      <Route exact path='/contact' component={Contact} />
    </div>
  </Router>
)
export default customRoutes;
