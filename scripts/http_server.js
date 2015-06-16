// Simple server -- invoked using curl http://localhost:4000
var http=require('http'),
  server;

server=http.createServer(function(request, response) {
  console.log(request.body)
  response.writeHead(200,{'Content-Type': 'text/html','Daves-header':'hey hey fat boy!'});
  response.end('Message received...\n');
}).listen(3000);