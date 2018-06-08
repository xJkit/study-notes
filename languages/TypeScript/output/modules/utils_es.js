"use strict";
/**
 * ES Module examples
 * Ths Syntax looks like the same as JavaScript ES6
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.foo = function () {
    console.log('========es module===================');
    console.log('foo function is exported');
    console.log('====================================');
};
exports.bar = function () {
    console.log('======es module=====================');
    console.log('bar function is exported');
    console.log('====================================');
};
exports.default = (function () {
    console.log('======es module=====================');
    console.log('This anonymous function is exported as default');
    console.log('====================================');
});
