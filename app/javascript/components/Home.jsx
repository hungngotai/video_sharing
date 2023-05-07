import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";
import Notification from "./Notification";
import moment from "moment";

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
        setVideos(data)
      })
      .catch(() => {
        localStorage.removeItem("token")
        navigate("/sign_in")
      });
  }, []);

  const allVideos = videos.map((video, index) => (
    <div className="col" key={index}>
      <div className="card shadow-sm">
        <iframe
          width="100%"
          height="225"
          src={video.src}
          frameborder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
          allowfullscreen="allowFullScreen"
        />
        <div className="card-body">
          <p className="card-text">{video.description}</p>
          <div className="d-flex justify-content-between align-items-center">
            <div className="btn-group">
              <button type="button" className="btn btn-sm btn-outline-secondary"><i class="bi bi-hand-thumbs-up"></i></button>
              <button type="button" className="btn btn-sm btn-outline-secondary"><i class="bi bi-hand-thumbs-down"></i></button>
            </div>
            <small className="text-body-secondary">{ moment(video.created_at).fromNow() }</small>
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
          <h1 className="fw-light">Youtube Video Sharing</h1>
          <p className="lead text-body-secondary">Share your favorite you videos</p>
          <p>
            <Link to="/share" className="btn btn-primary my-2">Share a new video</Link>
            <a href="#" className="btn btn-secondary my-2">Sign out</a>
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

    { localStorage.getItem("token") ? <Notification channel={ "NotificationChannel" } /> : null }
  </main>
)};
