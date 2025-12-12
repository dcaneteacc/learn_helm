// app.js
const express = require("express");
const app = express();

app.get("/", (req, res) => {
  const message = process.env.MY_VAR || "NO_DEF";

  res.send(`
    <!DOCTYPE html>
    <html>
    <body>
      <h1>Environment variable:</h1>
      <p><strong>${message}</strong></p>
    </body>
    </html>
  `);
});

app.listen(3000, () => console.log("Server into http://localhost:3000"));
