import React from "react";
import { createRoot } from "react-dom/client";
import App from "./App";

document.addEventListener("turbo:load", () => {
  const el = document.createElement("div")
  el.id = "root"
  const root = createRoot(
    document.body.appendChild(el)
  );
  root.render(<App />);
});
