import React from "react";
import { BrowserRouter as Router, Routes, Route, Navigate, Outlet } from "react-router-dom";
import Home from "../components/Home";
import Signin from "../components/Signin";
import Signup from "../components/Signup";

const AuthenticatedRoute = ({ redirectPath = '/signin' }) => {
  if (!localStorage.getItem("token")) {
    return <Navigate to={redirectPath} replace />;
  }

  return <Outlet />;
};

const UnAuthenticatedRoute = ({ redirectPath = '/' }) => {
  if (!!localStorage.getItem("token")) {
    return <Navigate to={redirectPath} replace />;
  }

  return <Outlet />;
};

export default (
  <Router>
    <Routes>
      <Route element={<UnAuthenticatedRoute />}>
        <Route path="/signin" element={<Signin />} />
        <Route path="/signup" element={<Signup />} />
      </Route>
      <Route element={<AuthenticatedRoute />}>
        <Route path="/" element={<Home />} />
      </Route>
    </Routes>
  </Router>
);
