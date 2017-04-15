# Redux Saga Notes

由於 ``Redux`` 在做非同步請求時不論使用 ``redux-thunk`` 寫在 action creators 裡，或是將 ``promise`` 寫在 React Component 裡面都不妥；前者造成測試的困難，而且污染 action creators 讓他的產出是一個 thunk function 而不是 pure object；後者更慘，不但污染了 React Component 的程式碼，而且還在裡面一隻 ``..then...then...then`` 非常之醜陋。因此， ``redux-saga`` 的誕生解決掉以上痛點。


## Introduction to Redux Saga

Saga 為一個對付 Side Effects(非同步請求) 的 pattern, 監聽 actions 來執行具有 Side Effects 的相對應任務(task),以保持 action 的簡潔，稱為 **``Watch/Worker``**.

1. 身為 ``Redux`` 的 **Middleware**, 將所有非同步的行為(Side Effects) 透過 **Middleware** 導到 Saga Pattern 統一處理。
2. 充分利用 JavaScript ES6 ``Generators`` 的特性，將非同步寫成同步，同時讓測試程式碼非常好寫。

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
  ```

## References
1. [redux-saga - Github](https://github.com/redux-saga/redux-saga)
2. [redux-saga - API Reference](https://redux-saga.github.io/redux-saga/docs/api/index.html#callfn-args)
3. [redux-saga - helpers](https://redux-saga.github.io/redux-saga/docs/basics/UsingSagaHelpers.html)
4. 部落格：
  * [知乎：redux-saga 實踐總結](https://zhuanlan.zhihu.com/p/23012870) by Jason Huang