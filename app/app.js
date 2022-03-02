const express = require('express')
const app = express()
const port = 8080

app.get('/', (req, res) => {
  res.sendFile(__dirname + '/img/pizza.png')
})

app.listen(port, () => {
  console.log(`Pizza app listening on port ${port}`)
})