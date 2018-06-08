import EsUtil, { foo, bar } from './utils_es'; // es modules

import commonUtil = require('./utils_commonjs');

EsUtil();
foo();
bar();

commonUtil.commonFoo();
commonUtil.commonBar();
