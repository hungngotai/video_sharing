import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import toastr from "toastr";

export default () => {
  const navigate = useNavigate();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const onChange = (event, setFunction) => {
    setFunction(event.target.value);
  };

  const onSubmit = (event) => {
    event.preventDefault();
    const url = "/users/sign_in";

    if (email.length == 0 || password.length == 0)
      return;

    const body = {
      user: {
        email,
        password
      }
    };
    fetch(url, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    })
      .then((response) => {
        localStorage.setItem('token', response.headers.get('authorization'))
        return response.json()
      })
      .then((data) => {
        if (data.error) { throw new Error(data.error) }

        toastr.success(data.message)
        navigate("/")
      })
      .catch((error) => toastr.error(error.message));
  };

  return (
    <div id="page-signin">
      <main className="form-signin w-100 m-auto">
        <form onSubmit={onSubmit}>
          <h1 className="h3 mb-3 fw-normal">Please sign in!</h1>

          <div className="form-floating">
            <input
              type="email"
              className="form-control"
              id="floatingInput"
              placeholder="name@example.com"
              onChange={(event) => onChange(event, setEmail)}
            />
            <label htmlFor="floatingInput">Email address</label>
          </div>
          <div className="form-floating">
            <input
              type="password"
              className="form-control"
              id="floatingPassword"
              placeholder="Password"
              onChange={(event) => onChange(event, setPassword)}
            />
            <label htmlFor="floatingPassword">Password</label>
          </div>
          <button className="w-100 btn btn-lg btn-primary" type="submit">Sign in</button>
          <Link to="/sign_up" className="d-block mt-3">Go to Sign up</Link>
          <p className="mt-5 mb-3 text-body-secondary">&copy; 2017–2023</p>
        </form>
      </main>
    </div>
  )
};
