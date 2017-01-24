# Socket.io Notes
Realtime Application Framework.

### Reference

* [Socket.io Official Website](http://socket.io/)
* [Socket.io Github](https://github.com/socketio)
* [Socket.io - NodeJS server](https://github.com/socketio/socket.io)
* [Socket.io - Client](https://github.com/socketio/socket.io-client)


### Installation

```sh
$ npm install socket.io
```

### Server Socket 使用方式
在 NodeJS Server 端使用 Socket 時必須包裝在 http.createServer 之上，因此若使用 Express framework 包裝順序為:

```javascript
const app = require('express')(); // express framework
const http = require('http'); // node.js http server
const socketIO = require('socket.io'); // socket.io
// 包裝開始
const server = http.createServer(app) // 使用原生 http 包裝 express app
const io = socketIO(server); // 再把包裝過的 server 包裝成 io

// 快速寫法
const app = require('express')();
const server = require('http').createServer(app);
const io = require('socket.io')(server);

// 開始使用
io.on('connection', socket => {
  console.log('a user connected');
  socket.on('createMsg', msg => {
    console.log(`got messages, ${msg.name}: ${msg.text}`);
    socket.emit('newMsg', {
      name: msg.name,
      text: msg.text,
      createdAt: new Date(),
    });
  });
  socket.on('disconnect', () => {
    console.log('a user disconnected');
  });
});

// 最終啟動伺服器應使用 Node.js 原生 http 的物件：
const ADDR = 'localhost';
const PORT = process.env.PORT || 3000;
server.listen(, err => {
  console.log(`Server fires up at ${ADDR}:${PORT}`);
})
```
