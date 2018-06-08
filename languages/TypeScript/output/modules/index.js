"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var utils_es_1 = __importDefault(require("./utils_es")); // es modules
var utils_commonjs_1 = __importDefault(require("./utils_commonjs"));
utils_es_1.default();
utils_es_1.foo();
utils_es_1.bar();
utils_commonjs_1.default.commonFoo();
utils_commonjs_1.default.commonBar();
