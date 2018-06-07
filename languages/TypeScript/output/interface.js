"use strict";
/**
 * Interface
 * >> a blueprint for an object (loosely)
 * 一個藍圖的概念
 */
function sayHello(jay) {
    console.log("Hi, " + jay.name);
    console.log("You are " + jay.age + " years old!");
    if (jay.married) {
        console.log('oh, you married! sadness...');
    }
    else {
        console.log('oop you are single!! cheers!');
    }
}
/*

sayHello({ label: "Chung" }); // error: not assignable to type Jay.

*/
sayHello({
    name: "Jay",
    age: 20
});
