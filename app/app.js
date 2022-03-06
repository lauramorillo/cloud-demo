const express = require('express')
const pizzaController = require('./controllers/pizza')
const app = express()
const port = 8080

app.get('/', pizzaController.getPizza)

app.listen(port, () => {
  console.log(`Pizza app listening on port ${port}`)
})