# Redux Saga Notes

由於 ``Redux`` 在做非同步請求時不論使用 ``redux-thunk`` 寫在 action creators 裡，或是將 ``promise`` 寫在 React Component 裡面都不妥；前者造成測試的困難，而且污染 action creators 讓他的產出是一個 thunk function 而不是 pure object；後者更慘，不但污染了 React Component 的程式碼，而且還在裡面一隻 ``..then...then...then`` 非常之醜陋。因此， ``redux-saga`` 的誕生解決掉以上痛點。


## Introduction to Redux Saga

Saga 為一個對付 Side Effects(非同步請求) 的 pattern, 監聽 actions 來執行具有 Side Effects 的相對應任務(task),以保持 action 的簡潔，稱為 **``Watch/Worker``**.

1. 身為 ``Redux`` 的 **Middleware**, 將所有非同步的行為(Side Effects) 透過 **Middleware** 導到 Saga Pattern 統一處理。
2. 充分利用 JavaScript ES6 ``Generators`` 的特性，將非同步寫成同步，同時讓測試程式碼非常好寫。

## 與傳統非同步 apiMiddlewares 比較

使用 Redux 的 F2E 通常都會擁有自己的一套 apiMiddleware 用以共用整個 SPA 非同步請求的程式碼片段。通常實作方式為將 **RSAA --> FSA**， 也就是將 ``Redux Standard API-calling Actions`` 轉譯為 ``Flux Standard Actions``. Action Creators 返回 [CALL_API] 的屬性代表非同步請求並被 apiMiddleware 捕捉，發出 REQUEST type action 後進行非同步請求處理；成功取得資料，返回 SUCCESS type action, 失敗返回 FAILURE type action. [redux-api-middleware](https://github.com/agraboso/redux-api-middleware)就是此案例的傳統實作方式（我個人通常也是如此）。

## Effects

1. 是一個 JavaScript Object
2. 是一個包含 Side Effects 訊息的 Object
3. 必須通過 ``yield`` 吐給 sagaMiddleware 才會執行
4. 承上，所有的 ``yield`` 後面應該為 Effects

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
  1. ``fork``
    * 非同步呼叫子 Saga
    * **fork** Effect 即為創造一個子 Saga.
    * 範例：
      * 當收到 **BEGIN_COUNT** action  --> 開始倒數
      * 當收到 **STOP_COUNT** action --> 停止倒數
  ```js
    function* countSaga() {
      while(true) {
        const { payload: number } = yield take('BEGIN_COUNT');
        const countTaskId = yield fork(count, number); // count 為一個 generator

        yield take('STOP_TASK');
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
  2. ``call``
    * 同步（阻塞）呼叫子 Saga，或者返回 **Promise** 物件
  ```js
    const project = yield call(fetch, {
      url: UrlMap.fetchProject,
    });
    
    const members = yield call(fetchMembers, project.id);
  ```

## References
1. [redux-saga - Github](https://github.com/redux-saga/redux-saga)
2. [redux-saga - API Reference](https://redux-saga.github.io/redux-saga/docs/api/index.html#callfn-args)
3. [redux-saga - helpers](https://redux-saga.github.io/redux-saga/docs/basics/UsingSagaHelpers.html)
4. 部落格：
  * [知乎：redux-saga 實踐總結](https://zhuanlan.zhihu.com/p/23012870) by Jason Huang