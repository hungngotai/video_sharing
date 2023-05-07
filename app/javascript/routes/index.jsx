import React from "react";
import { BrowserRouter as Router, Routes, Route, Navigate, Outlet } from "react-router-dom";
import Home from "../components/Home";
import SignIn from "../components/SignIn";
import SignUp from "../components/SignUp";
import Share from "../components/Share";

const AuthenticatedRoute = ({ redirectPath = '/sign_in' }) => {
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
        <Route path="/sign_in" element={<SignIn />} />
        <Route path="/sign_up" element={<SignUp />} />
      </Route>
      <Route element={<AuthenticatedRoute />}>
        <Route path="/share" element={<Share />} />
        <Route path="/" element={<Home />} />
      </Route>
    </Routes>
  </Router>
);
