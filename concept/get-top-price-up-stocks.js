#!/usr/bin/nodejs

var http = require('http')

var option = {
  hostname: 'quotes.money.163.com',
  path: '/hs/service/diyrank.php?page=0&query=STYPE%3AEQA&fields=NO%2CSYMBOL%2CNAME%2CPRICE%2CPERCENT&sort=PERCENT&order=desc&count=50&type=query'
}

var parse_rank = function(data) {
  data =JSON.parse(data)
  for(var index in data.list) {
    item = data.list[index]
    if(item.PERCENT >= 0.09) {
      console.log(item.SYMBOL + ',' + item.NAME)
    }
  }
}

var callback = function(resp) {
  var str = ''
  resp.on('data', function(chunk) {
    str += chunk
  })

  resp.on('end', function() {
    parse_rank(str)
  })
}

http.request(option, callback).end()
