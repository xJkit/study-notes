"use strict";
/**
 * Inheritance
 */
var __extends = (this && this.__extends) || (function () {
    var extendStatics = Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
        function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
var Person = /** @class */ (function () {
    function Person(name) {
        this.name = name;
    }
    Person.prototype.dance = function () {
        console.log('====================================');
        console.log(this.name + " is dancing...");
        console.log('====================================');
    };
    return Person;
}());
var Jay = new Person('Jay Chung');
Jay.dance(); // Jay Chung is dancing...
/** extends */
var Hero = /** @class */ (function (_super) {
    __extends(Hero, _super);
    function Hero() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    Hero.prototype.dance = function () {
        console.log('====================================');
        console.log("Hero " + this.name + " is dancing amazing!!!");
        console.log('====================================');
    };
    Hero.prototype.superDance = function () {
        _super.prototype.dance.call(this);
    };
    return Hero;
}(Person));
var Faye = new Hero('Faye Lin');
Faye.dance(); // Hero Faye Lin is dancing amazing!!!
Faye.superDance(); // Faye Lin is dancing...
