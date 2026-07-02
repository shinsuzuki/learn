const bodyParser = require("body-parser");
const express = require("express");

const eventRoutes = require("./routes/events");
const authRoutes = require("./routes/auth");

const app = express();

app.use(bodyParser.json());
app.use((req, res, next) => {
  // res.setHeader("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Origin", "http://localhost:3000");
  res.setHeader("Access-Control-Allow-Methods", "GET,POST,PATCH,DELETE,OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type,Authorization");

  // OPTIONS のプリフライトをここで終了させる
  if (req.method === "OPTIONS") {
    return res.sendStatus(200);
  }

  next();
});

app.use(authRoutes);

app.use("/events", eventRoutes);

app.use((error, req, res, next) => {
  const status = error.status || 500;
  const message = error.message || "Something went wrong.";
  res.status(status).json({ message: message });
});

app.listen(8080);
