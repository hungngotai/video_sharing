import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";
import toastr from "toastr";
import useConsumer from "../channels/consumer";

const consumer = useConsumer();

export default ({ channel }) => {
  const [message, setMessage] = useState('');

  useEffect(() => {
    consumer.subscriptions.create(
      { channel },
      {
        connected() {
          console.log('connected')
        },
        received({ message }) {
          setMessage(message)
        }
      }
    )

    return () => {
      consumer.disconnect()
    }
  });

  useEffect(() => {
    if (message.length) toastr.info(message)
    setMessage('')
  }, [message])

  return
};
