"use strict";
/** Basic Types Demo */
Object.defineProperty(exports, "__esModule", { value: true });
var isWinter = false;
var count = 1234;
var name = 'Jay Chung';
var names = ['Jay', 'Faye', 'Can', 'Jim'];
var HttpMethods;
(function (HttpMethods) {
    HttpMethods[HttpMethods["GET"] = 0] = "GET";
    HttpMethods[HttpMethods["POST"] = 1] = "POST";
    HttpMethods[HttpMethods["DELETE"] = 2] = "DELETE";
    HttpMethods[HttpMethods["PATCH"] = 3] = "PATCH";
    HttpMethods[HttpMethods["HEAD"] = 4] = "HEAD";
})(HttpMethods || (HttpMethods = {}));
var response = HttpMethods.POST;
function countChar(chars) {
    return chars.length;
}
countChar('Jay Chung');
