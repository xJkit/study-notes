# Socket.io Notes
* A JavaScript library for realtime web applications built on top of ``WebSockets API(Client side)`` and ``Node.js``.
* Both client side and server side components have a nearly identical API.
* Realtime 應用程式適用場景：
  1. Instant Messengers (通訊軟體 WhatsApp, Facebook messengers. 無須 refresh 取得訊息)
  2. Push Notifications (當你被 Facebook 朋友 tag 時立馬收到通知)
  3. Collaboration Apps (Google doc, 多人同時編輯)
  4. Online Gaming (多人即時線上遊戲)

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

### Client Socket
[Client Socket API](https://github.com/socketio/socket.io-client/blob/master/docs/API.md#io)
在一般的 HTML document, 若 server 端使用了 socket.io 函式庫，則會自動暴露在 url 路由：```/socket.io/socket.io.js```，直接在 ```<script>``` 標籤中 get 即可使用：
```html
<script src="/socket.io/socket.io.js"></script>
<script>
  var socket = io('http://localhost');
  socket.on('connect', function(){});
  socket.on('event', function(data){});
  socket.on('disconnect', function(){});
</script>
```

在 React 中，使用 [socket.io-client](https://www.npmjs.com/package/socket.io-client) 並 import 到 Component 中即可：
```javascript
const io = require('socket.io-client');
const socket = io();
// 以下雷同
```

### Event Handling
1. Server-sidie reserved events:
  * connect
  * message
  * disconnect
  * reconnect
  * ping
  * join
  * leave

2. Client-side reserved events:
  * connect
  * connect_error
  * connect_timeout
  * reconnect

3. Broadcasting:
  * Server 使用 ``io.sockets.emit`` 來發送廣播給所有人 (p.s 其實是 Namespace 下的所有人)
  ```javascript
    io.on('connection', socket => {
      io.sockets.emit('broadcast', {
        description: 'Hi, this is the broadcast events!',
      });
    });
  ```
  * Client 端接收方式：
  ```javascript
    const socket = io();
    socket.on('broadcast', data => {
      console.log(`Got broadcast messages: ${data.description}`);
    });
  ```
  * 注意：若廣播事件為 client 端所造成，應改為 ``socket.broadcast.emit``. 這將使得廣播的使用者與其他使用者受到不同的訊息。
    * 舉例來說，新使用者登入時將收到 ``歡迎光臨!`` 而其他使用者將收到 `` xx 使用者在線上``
    * Server 端接受方式：
    ```javascript
      io.on('coonnection', socket => {
        clients++;
        socket.emit('newClient', {
          description: '歡迎光臨!',
        });
        socket.broadcast.emit('newClient', {
          description: `${clients} 使用者在線上`,
        });
        socket.on('disconnect', () => {
          clients--;
          socket.broadcast.emit('newClient', {
            description: `${clients} 使用者在線上`
          });
        });
      });
    ```
    * Client 端接收方式：
    ```javascript
      const socket = io();
      socket.on('newClient', data => {
        console.log(`Got messages: ${data.description}`);
      });
    ```

### Namespaces & Rooms
* Reference
  * [socket.io 中 namespace 和 room 的概念。](http://blog.csdn.net/lijiecong/article/details/50781417)
  * [socket.io的命名空间(namespace)和房间(room)](http://www.itye.org/archives/2816)

``Namespace`` 用途為透過指定不同的 endpoints 或 paths 以減少過多的連線數量。
``Room`` 為 Namespace(空間) 下的不同頻道，可以 **join(加入)** 與 **leave(離開)**, 用途為進一步的連線區隔。

* 三者關係： ``Namespace``(空間) > ``Room``(房間) > ``Socket``(個體)
* 預設的空間為 ``/`` , Client 與 Server 將會在此溝通
* 自訂 __NameSpace__
  1. Server-side:

    ```javascript
      const app = require('express')();
      const server = require('http').createServer(app); // 將 express app 透過原生 http 包裝成 server 物件
      const io = require('socket.io')(server); //透過 socketIO 將 server 包成 io 物件
      /****** 訂製 NameSpace ******/
      const nsp = io.of('/my-namespace-name');
      // 透過自定義的命名空間 nsp 作為取代預設為 / 的 io
      nsp.on('connection', socket => {
        console.log('a user connected');
        nsp.emit('greeting', {
          description: 'good morning, everybody!'
        }); // 透過 nsp 發送給每一個在空間裡的 socket
      })
      // 正常的 server 啟動程序
      server.listen(3000, () => {
        console.log(`server is up at port 3000...`);
      });
    ```

  2. Client-side:
   * 在 ``io`` 的 constructor 中丟進 NameSapce:

   ```javascript
     const io = require('socket.io-client');
     const socket = io('/my-namespace-name');
     socket.on('greeting', data => {
       console.log(`got message: ${data.description}`);
     });
   ```

* 自訂 __Room__ 頻道
  1. 在一個指定的 NameSpace(空間)下，能夠加入(join)與離開(leave)不同的頻道
  2. 只有 __Server-side__ 能決定某個連線個體(socket)所加入的 room 或離開它
  * 用法：
    1. 使用 ``socket.join('room-name')`` 將個體加入 room
    2. 使用 ``io.sockets.in('room-name').emit('event', 'msg') 寄給在這個 room 頻道下的所有人``
  * 用法範例：
    1. Server-side:

    ```javascript
      const app = require('express')();
      const server = require('http').createServer(app); // 將 express app 透過原生 http 包裝成 server 物件
      const io = require('socket.io')(server); //透過 socketIO 將 server 包成 io 物件
      // use default namespace
      io.on('connection', socket => {
        socket.join('room-name'); // 加入頻道
        io.sockets.in('room-name').emit('connectToRoom', 'You are in this room');
        socket.leave('room-name'); // 離開頻道
      });
      // ... omit the express server
    ```

    2. Client-side: 與之前都相同
