const path = require('path')

exports.getPizza = (req, res) => {
  res.sendFile('pizza.png', { root: path.join(__dirname + '/../img') })
}