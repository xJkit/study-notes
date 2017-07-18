# Electron 研讀心得

Electron 基於 Chromium 瀏覽器而發展的 Desktop App, 想像運作如同打開 Chrome 瀏覽器，擁有 `Chrome`(main process)主程式本身，以及 Tabs(renderer processes) -> 分別畫出 Web Page，且每一個 renderer process 都是 sandbox.

## History of Electron

GitHub > Electron > Atom.

1. GitHub 本為代碼管理中心，某一天突然想涉入代碼創造的過程，何不為自己創造一個 IDE?
1. 經過研究發現，第一名在 GitHub 上代管的程式碼為 `JavaScript`，因此決定用 JS 寫 IDE.
1. GitHub 使用 JS 創造了 Atom 並且有豐富的外掛模組擴充，讓社群更強大。
1. 越來越多人發現使用 JS 寫 Web App 的優點，開始想移植到 Desktop App.
1. 越來越多公司和平台使用 Electron 寫 Desktop App, 例如 `Slack`, `VSCode` 之類。

## 重要的 Electron properties

`Electron App` ----> `App`(Main/Browser Window) ---> Render processes

* Electron App 就是 electron 本身，透過 `const electron = require('electron');`，由 Electron 自己產生
* App 視為瀏覽器視窗, 為 electron 最重要的 property, 由我們創造。
* Electron 並非僅是一個簡單的 library, 而是一個 ecosystem, 必須搭配工具使用，常用的有：
    1. `electron`: electron 核心 library, 包含 cli, 例如 `electron .`

常使用的 property object:

* `app`
  * 在 `require('electron')` 裡面，代表 electron app.
* `BrowserWindow`
  * 視窗物件，透過 `new BrowserWindow()`
  * 方法：
    * loadURL(*url*): 打開視窗後讀取 url 或檔案
      * 例如 `loadURL('https://tw.yahoo.com')` 就是開啟一個網站
      * loadURL(`file://${__dirname}/index.html`) 開啟本地 html 檔案
* `ipcRenderer` 在 MainWindow 與 Electron 溝通的 api object
  * 存在於 `BrowserWindow` 或是 client
  * `.send` 發送訊息
  * `.on` 接收訊息
* `ipcMain` 在 Electron 監聽 Window 發送過來的 stream messages
  * 存在於 `Electron App`
  * `.on` 接受訊息
  * 如何發送訊息？ 使用 *BrowserWindow* 的實體 `MainWindow` 透過 WebContents.send:
* `Menu`
  * 產生作業系統的 menu bar
  * .buildFromTemplate(*menuTemplate*)
  * .setApplicationMenu(*mainMenu*)
  * menuTemplate:
    * label: *string* - 選單名稱
    * accelerator: *string* - 組合快捷鍵
    * click: *function* - 點擊

  ```js
  const { app, BrowserWindow, ipcMain } = require('electron');
  let MainWindow;
  app.on('ready', ( => {
      MainWindow = new BrowserWindow();
  });
  ipcMain.on('event:greeting', (evt, data) => {
    console.log(`I got client message ${data}`);
    const greetingFromElectron = 'Hi, there!';
    MainWindow.webContents.send('event:response', greetingFromElectron);
  });
  ```

### Electron Life Cycle

Electron Starts ---> `app` process is created ---> app `ready` to do things ---> app `close` down

由於我們必須要知道 app 何時 `ready`, 因此使用 `事件監聽` 的方式來等待 `ready` 事件，並把 ready 後該做的事放在 callback function (event-based programming)

`event-based programming`:

![imgurl](http://i.imgur.com/pB6MhYW.png)

## 使用 FFMPEG 轉檔

ffmpeg 為著名的多媒體編碼與賺轉碼工具，其他研讀筆記紀錄在 `study-notes` 裡。

> 針對 node.js 使用 ffmpeg-fluent 函式庫作為 api 使用

## IPC (Inter-Process Communication system)

Electron 並非完全像 Chrome, 而是 `Electron = Chorme + NodeJS`.

* Electron 擁有 Node.js 的 commonJS module system, 讓前端可以使用 `require`
  * 打開 Electron, 開啟 devTool 可以直接使用 require!
* Electron 擁有 Node.js 的 built in modules, 如 `fs`, `crypto`, etc.

Electron App                | <----IPC------->                    | MainWindow
----------------------------|-------------------------------------|------------------
ipcMain.on                  | <--- I need info about this video-- | ipcRenderer.send
mainWindow.webContents.send | -- Ok, here's what I found --->     | ipcRenderer.on

> 注意： `mainWindow` 為 new BrowserWindow() 所產生的 global variable object, 看你要 send 到哪一個 window 就對了

## 製作 Menu Bars

Menu bar 使用於桌面應用的選單，在 Mac OS 中當點擊應用程式時就位於上方蘋果旁。

```js
  const { Menu } = require('electron');
```

* `buildFromTemplate` 製作選單， 參數是一個 array of object.

* `setApplicationMenu`, 將 buildFromTemplate 產生的 menu 物件畫出來。

```js
  const menuTemplate = [{
    label: 'File',
    submenu: [{
      label: 'Add New Todo',
    }],
  }];

  const mainMenu = Menu.buildFromTemplate(menuTemplate);
  Menu.setApplicationMenu(mainMenu);
```

* `menuTemplate` - 一個 array of object, 包含以下屬性/方法：
  * label
  * accelerator
  * click

> 注意：當你使用 `setApplicationMenu` 時，預設的 Electron 視窗功能（包含 reload, quit, devTools, ...）等全部都會消失，並且被新的 menuTemplate 取代。

`Mac OS` 和 `Windows` 在 menuTemplate 的顯示方式略有不同：前者的 menuTemplate[0] 也就是第一個選單都不會顯示，並且被自動綁定到 `App Name` 底下的選單（預設叫 `Electron`）, 然而後者則是會顯示。因此，可透過 node.js 的 `process.platform` 來 quick fix 加入一個空的物件防止被 Electron 綁架:

```js
  if (process.platform === 'darwin') {
    menuTemplate.unshift({});
  }
```

## 管理多個視窗

Electron Desktop App 跟 Web App 最大的不同是， Desktop App 必須管理 app.quit() 以下在 Menu Bar 中新增 Add todo:

```js
const { app, BrowserWindow, Menu } = require('electron');
let todoWindow;
let mainWindow;

const menuTemplate = [{
  label: 'New Todo',
  click: () => {
    todoWindow = new BrowserWindow({ width: 300, height: 200, title: 'New Todo' }),
    todoWindow.loadURL(`file://${__dirname}/todo.html`);
  },
}, {
  label: 'quit',
  click: () => app.quit(),
}];

app.on('ready', () => {
  mainWindow = new BrowserWindow({});
  mainWindow.loadURL(`file://${__dirname}/index.html`);
  mainWindow.on('closed', () => {
    app.quit();
    // 這段必須判斷，因為當你開著 Todo 新視窗時，隨時關閉 mainWindow 就應該要 Quit 掉整個應用程式啦！
  });
  const mainMenu = Menu.buildFromTemplate(menuTemplate);
  Menu.setApplicationMenu(mainMenu);
});

```

## FAQ

1. 功能邏輯應該寫在 Web App 裡，還是寫在 Electron App 裡？
> 習慣是，跟作業系統有關的功能(*file system, operation system*)寫在 Electron, 其他都可以寫在 Web

## Projects

1. [videoinfo](https://github.com/xJkit/videoinfo.git)