import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import toastr from "toastr";

export default () => {
  const navigate = useNavigate();
  const [src, setSrc] = useState('');
  const [description, setDescription] = useState('');

  const onChange = (event, setFunction) => {
    setFunction(event.target.value);
  };

  const onSubmit = (event) => {
    event.preventDefault();
    const url = "/api/v1/videos";

    if (src.length == 0)
      return;

    const body = {
      video: {
        src,
        description
      }
    };
    fetch(url, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": localStorage.getItem("token")
      },
      body: JSON.stringify(body),
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.error) { throw new Error(data.error) }

        toastr.success(data.message)
        navigate("/")
      })
      .catch((error) => {
        toastr.error(error.message)
      });
  };

  return (
    <div id="page-signin">
      <main className="form-signin w-100 m-auto">
        <form onSubmit={onSubmit}>
          <div className="form-floating">
            <input
              type="url"
              className="form-control mb-3"
              id="floatingInput"
              placeholder="https://www.youtube.com/embed/youtube_video_id"
              onChange={(event) => onChange(event, setSrc)}
            />
            <label htmlFor="floatingInput">Embed Link</label>
          </div>
          <div className="form-floating">
            <input
              type="text"
              className="form-control mb-3"
              id="floatingPassword"
              placeholder="Describe about your favorite video"
              onChange={(event) => onChange(event, setDescription)}
            />
            <label htmlFor="floatingPassword">Description</label>
          </div>
          <button className="w-100 btn btn-lg btn-primary" type="submit">Share</button>
          <Link to="/" className="d-block mt-3">Go back</Link>
        </form>
      </main>
    </div>
  )
};
