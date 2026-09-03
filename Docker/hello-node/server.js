const http = require('node:http');

const server = http.createServer((_request, response) => {
  response.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
  response.end('<!doctype html><html><body><h1>Hello World from Node.js</h1></body></html>');
});

server.listen(8080, '0.0.0.0', () => {
  console.log('Node.js Hello World listening on port 8080');
});
