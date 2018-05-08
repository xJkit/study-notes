# Redux Saga Notes

由於 ``Redux`` 在做非同步請求時不論使用 ``redux-thunk`` 寫在 action creators 裡，或是將 ``promise`` 寫在 React Component 裡面都不妥；前者造成測試的困難，而且污染 action creators 讓他的產出是一個 thunk function 而不是 pure object；後者更慘，不但污染了 React Component 的程式碼，而且還在裡面一隻 ``..then...then...then`` 非常之醜陋。因此， ``redux-saga`` 的誕生解決掉以上痛點。

<!--總結目前業界在 flux 中處理 side effects 方式：
1. promise-based (in react component)
1. redux-api-middleware (promise in redux middleware)
1. redux-thunk (in action)
1. redux-observables (with Rx.js in redux middleware)
1. redux-saga (Saga pattern in redux middleware)-->

## 與傳統非同步 apiMiddlewares 比較

使用 Redux 的 F2E 通常都會擁有自己的一套 apiMiddleware 用以共用整個 SPA 非同步請求的程式碼片段。通常實作方式為將 **RSAA --> FSA**， 也就是將 ``Redux Standard API-calling Actions`` 轉譯為 ``Flux Standard Actions``. Action Creators 返回 [CALL_API] 的屬性代表非同步請求並被 apiMiddleware 捕捉，發出 REQUEST type action 後進行非同步請求處理；成功取得資料，返回 SUCCESS type action, 失敗返回 FAILURE type action. [redux-api-middleware](https://github.com/agraboso/redux-api-middleware)就是此案例的傳統實作方式（我個人通常也是如此）。如果有更進一步處理的需求，會結合 [redux-thunk](https://github.com/gaearon/redux-thunk) 做更深層的資料流處理，但是相對的會污染 actions (不再是 pure object, 而是 thunk function)。

總結：在 Redux 中處理非同步的五種主流方式：

1. fetch in react component (污染組件)
1. Promise-based api middleware (例如 [redux-api-middleware](https://github.com/agraboso/redux-api-middleware) 或是自幹 redux middleware)
1. [redux-thunk](https://github.com/gaearon/redux-thunk) (maybe with ES7 ``async/await``)
1. [redux-observable](https://github.com/redux-observable/redux-observable) - 結合 Rx.js 在 redux middleware 裡
1. [redux-saga](https://github.com/redux-saga/redux-saga) (就是本篇)

  > [Why do we need middleware for async flow in Redux?](http://stackoverflow.com/questions/34570758/why-do-we-need-middleware-for-async-flow-in-redux/34623840#34623840) - 重點文摘：作者說 action creators 不再需要保持 pure functions

  > [文章比較：Thunk(async/await) V.S Redux-Saga](http://stackoverflow.com/questions/34930735/pros-cons-of-using-redux-saga-with-es6-generators-vs-redux-thunk-with-es7-async/34933395)

## Introduction to Redux Saga

Saga 為一個對付 Side Effects(非同步請求) 的 pattern, 監聽 actions 來執行具有 Side Effects 的相對應任務(task),以保持 action 的簡潔，稱為 **``Watch/Worker``**.

1. 身為 ``Redux`` 的 **Middleware**, 將所有非同步的行為(Side Effects) 透過 **Middleware** 導到 Saga Pattern 統一處理。
1. 充分利用 JavaScript ES6 ``Generators`` 的特性，將非同步寫成同步，同時讓測試程式碼非常好寫。


使用 ``Redux-Saga`` 優缺點分析：
* 缺點：
  * redux-saga 不強迫捕捉錯誤，這往往是造成錯誤發生而難以追蹤。

    > 良好的習慣： 捕捉每一個請求都設想失敗的可能性。

  * generator 開發環境在經過 babel 的 source-map 經常跑掉，常常需要 **debugger**
  * 使用 redux-saga 在團隊中難以良好搭配，也許需要一些代價或成本來重寫替換成 saga

* 優點：
  * 保持 action 一致簡潔，不讓 action creators 五花八門，眼花撩亂。
  * 提供豐富的 Effects 以及 Saga 機制（而且可隨時被中斷）

**小結：** Redux-Thunk 沒什麼不好，小專案還是可以用，而且搭配 ``async/await`` 非常直覺。倘若專案在非同步請求邏輯非常複雜，建議呼叫 Saga Pattern 來處理這一切。

類別          | Imperative  | Declarative
-------------|-------------|-------------
DOM          | jQuery      | React
Side Effects | Redux-Saga  | Redux-Observable


## Redux-Saga 術語對照表

![saga-flow](https://qiita-image-store.s3.amazonaws.com/0/69860/8cc1a873-c675-9009-570d-9684da4a704f.png)

Redux Saga                             | 相當於            | 描述
---------------------------------------|----------------|------------------------------------------------------------------------------
Effect                                 | RSAA           | 純粹 JS 物件，相當於處理非同步用的 action 物件
Task                                   | 執行緒            | 在Saga中可單獨作業的 Process, 也可以執行其他的 Saga, 透過 ``fork`` 建立 Task.
select(selector, ...args) | getState() | 指示調用的 selectors (然而 selector 就是 (state, ...args) => args)
阻塞、非阻塞呼叫                               | 同步、非同步         | Generator - 運轉停止，等待外部命令才執行 = ``阻塞｀``； Generator 運轉停止，等待狀態回應後自動繼續執行 = ``非阻塞``
yield ``take(ACTION)``                     | watch (阻塞)     | 監聽指定的 action type, 如 ``take('FETCH_USER_REQUEST')``
yield ``call(func 或 saga, ...arg)``       | watch (阻塞)     | 1. 等待正常func 回傳 Promise, 或 2. 等待 saga 運作終止
yield ``put(...)``                         | dispatch (非阻塞) | dispatch 內部的 scheduler
const task = yield ``fork(saga, ...args)`` | init 執行緒 (非阻塞) | 非同步，執行一個 process, 啟動 saga
yield ``cancel(task)``                     | restore (非阻塞)        | 非阻塞，立即恢復 task
yield ``join(task)``                       | wait and quit (阻塞)  | 阻塞，等待 task 終止
watcher | PM | 觀察被 dispatch 的 action 並在每個 action fork 一個 worker
worker | 結案人 | 處理 action 並終止

範例：
```js
  function* watcher() {
    while (true) {
      const action = yield take(ACTION)
      yield fork(worker, action.payload)
    }
  }

  function* worker(payload) {
  // ... 做其他事
}
```

* 深入研究，請看 >> [官方文檔 API Reference](https://neighborhood999.github.io/redux-saga/docs/api)

## Effects

1. 是一個 JavaScript Object
2. 是一個包含 Side Effects 訊息的 Object
3. 必須通過 ``yield`` 吐給 sagaMiddleware 才會執行
4. 承上，所有的 ``yield`` 後面應該為 Effects
5. 使用 redux-saga 的 Effect generators 建立此類物件（就像 Redux 中的 action creators）
  * 例： ``call(myFunc, arg1, arg2,  ...)`` 代表使用 myFunc(arg1, arg2, ...) 並產生 effect 物件供 saga middleware 處理

  ```js
    yield fetch(UrlMap.fetchData);
    // 上述應該透過 call effect 寫成：
    yield call(fetch, UrlMap.fetchData);
  ```

## 常用 APIs
  由於對 React 與 Redux 熟悉度較高，因此使用相對、比擬的方式來記憶 Saga 中 常見 API 的用途。

1. ``put``:
  * 如同 dispatch
  ```js
    yield put({
      type: 'CLICK_BTN',
    })
  ```

2. ``select``:
  * 如同 **getState()**. 在 **thunk**中擁有取得 store 的能力
  ```js
    const id = yield select(state => state.id);
  ```

3. ``take``:
  * **等待**/**監聽** redux 在 dispatch 時所匹配的某幾個 actions
  * 範例： 等待 action(按鈕點擊） ---> 執行對應的 Saga：
  ```js
    while(true) {
      yield take('CLICK_BTN');
      yield fork(clickBtnSaga);
    }
  ```
  * 範例：實現 logMiddleware
  ```js
    while (true) {
      const action = yield take('*');
      const newState = yield select();

      console.log('新的 action:', action);
      console.log('新的 state:', newState);
    }
  ```

4. ``takeEvery``:
  * 由於在 Saga 中 這種 ``監聽 action --> 執行 task`` 的行為被大量使用，因此 redux-saga 特別提供了 [Saga Helpers](https://redux-saga.github.io/redux-saga/docs/basics/UsingSagaHelpers.html)來包裝所謂的 ``Watch/Worker`` flow, 讓程式碼更加清晰。
  * `takeEvery` = `take` + `fork`
  * takeEvery('Type', saga) 觸發後會自動把 action 丟到 call back saga
  * 範例：實現 logMiddleware 變成
  ```js
    yield takeEvery('*', function* logger(action) {
      const newState = yield select();

      console.log('新的 action:', action);
      console.log('新的 state:', newState);
    });
    // takeEvery 替代了 使用 while 迴圈來監聽 action 的 take.
  ```

5. 同步／非同步呼叫 (Blocking/Non-blocking calls)
  在 Saga 中，一個 Saga 可有許多 ``子 Saga`` 所組成（或被稱為 sub-transaction）。因此，在 redux-saga 中透過 **fork** 以及 **call** 來實作。
  * ``fork``
    * 非同步呼叫子 Saga
    * **fork** Effect 即為創造一個子 Saga.
    * 範例：
      * 當收到 **BEGIN_COUNT** action  --> 開始倒數
      * 當收到 **STOP_COUNT** action --> 停止倒數
  ```js
    function* countSaga() {
      while(true) {
        const { payload: number } = yield take(BEGIN_COUNT);
        const countTaskId = yield fork(count, number); // count 為一個 generator

        yield take(STOP_TASK);
        yield cancel(countTaskId);
      }
    }
      // 補充： count generator
      function* count(number) {
        let currentNum = number;
        while (currentNum >= 0) {
          console.log(currentNum--);
          yield delay(1000);
        }
      }
  ```
  * ``call``
    * 同步（阻塞）呼叫子 Saga，或者返回 **Promise** 物件
  ```js
    const project = yield call(fetch, {
      url: UrlMap.fetchProject,
    });

    const members = yield call(fetchMembers, project.id);
  ```

6. [實作 Watcher (監聽 action) 三種方式](https://github.com/redux-saga/redux-saga/issues/684)：

  * while take

  ```js
  function* watchTodos() {
    while (yield take('FETCH_TODOS')) {
      yield fork(loadTodos);
    }
  }
  ```

  * while true

  ```js
  function* watchTodos() {
    while(true) {
      const action = yield take('FETCH_TODOS');
      yield fork(loadTodos, action);
    }
  }
  ```

  * takeEvery

  ```js
  function* watchTodos() {
    yield all([
      takeEvery('DELETE_FILE', deleteFile),
      takeEvery('LIST_FILES', listFiles),
    ])
  }
  ```

## References

1. [redux-saga - Github](https://github.com/redux-saga/redux-saga)
1. [redux-saga - API Reference](https://redux-saga.github.io/redux-saga/docs/api/index.html#callfn-args)
1. [redux-saga - helpers](https://redux-saga.github.io/redux-saga/docs/basics/UsingSagaHelpers.html)
1. [eslint-plugin-redux-saga](https://github.com/pke/eslint-plugin-redux-saga) - eslint 確保 saga 程式碼在每一個 effect 前都被 yield
1. 部落格：
  * [知乎：redux-saga 實踐總結](https://zhuanlan.zhihu.com/p/23012870) by Jason Huang