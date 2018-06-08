"use strict";
var commonFoo = function () {
    console.log('=========commonjs===========================');
    console.log('commonFoo function is exported');
    console.log('====================================');
};
var commonBar = function () {
    console.log('=========commonjs===========================');
    console.log('commonBar function is exported');
    console.log('====================================');
};
module.exports = {
    commonFoo: commonFoo,
    commonBar: commonBar
};
