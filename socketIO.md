# Socket.io Notes
Realtime Application Framework.

### Reference

* [Socket.io Official Website](http://socket.io/)
* [Socket.io Github](https://github.com/socketio)
* [Socket.io - NodeJS server](https://github.com/socketio/socket.io)
* [Socket.io - Client](https://github.com/socketio/socket.io-client)
* Tutorials:
  1. [TutorialsPoint](https://www.tutorialspoint.com/socket.io/index.htm)


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

### Namespaces & Rooms
* Reference
  * [socket.io 中namespace 和 room的概念。](http://blog.csdn.net/lijiecong/article/details/50781417)
  * [socket.io的命名空间(namespace)和房间(room)](http://www.itye.org/archives/2816)

1. Namespaces 用途為透過指定不同的 endpoints 或 paths 以減少過多的連線數量。
2. 若不指定， 則 client 端以及 server 端預設 namespace 皆為 ``/``.
3. 每一個 client 端的 socket 實體預設會發送 'connection' 事件，並且被當作 server 的參數丟進去做事：
```javascript
  io.on('connection', (socket) => {
    // ... new user connected
    socket.on('disconnect', () => {
      // a user disconnected
    });
  });
```
