import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";
import toastr from "toastr";

export default () => {
  const navigate = useNavigate();
  const [videos, setVideos] = useState([]);

  useEffect(() => {
    const url = "/api/v1/videos";
    fetch(url, {
      headers: {
        "Authorization": localStorage.getItem("token")
      }
    })
      .then((res) => {
        if (res.ok) {
          return res.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then(({ data }) => {
        toastr.success("aaaaaaa")
        setVideos(data)
      })
      .catch(() => {
        localStorage.removeItem("token")
        navigate("/signin")
      });
  }, []);

  const allVideos = videos.map((video, index) => (
    <div className="col" key={index}>
      <div className="card shadow-sm">
        <iframe width="100%" height="225" src={video.src}></iframe>
        <div className="card-body">
          <p className="card-text">{video.description}</p>
          <div className="d-flex justify-content-between align-items-center">
            <div className="btn-group">
              <button type="button" className="btn btn-sm btn-outline-secondary">View</button>
              <button type="button" className="btn btn-sm btn-outline-secondary">Edit</button>
            </div>
            <small className="text-body-secondary">9 mins</small>
          </div>
        </div>
      </div>
    </div>
  ));
  const noVideo = (
    <div className="vw-100 vh-50 d-flex align-items-center justify-content-center">
      <h4>
        No video yet. Why not <Link to="/new_video">create one</Link>
      </h4>
    </div>
  );

  return (
  <main>

    <section className="py-5 text-center container">
      <div className="row py-lg-5">
        <div className="col-lg-6 col-md-8 mx-auto">
          <h1 className="fw-light">Album example</h1>
          <p className="lead text-body-secondary">Something short and leading about the collection below—its contents, the creator, etc. Make it short and sweet, but not too short so folks don’t simply skip over it entirely.</p>
          <p>
            <a href="#" className="btn btn-primary my-2">Main call to action</a>
            <a href="#" className="btn btn-secondary my-2">Secondary action</a>
          </p>
        </div>
      </div>
    </section>

    <div className="album py-5 bg-body-tertiary">
      <div className="container">
        <div className="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
        { allVideos.length ? allVideos : noVideo }
        </div>
      </div>
    </div>
  </main>
)};
