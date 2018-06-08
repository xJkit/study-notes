/**
 * ES Module examples
 * Ths Syntax looks like the same as JavaScript ES6
 */

export const foo = () => {
  console.log('========es module===================');
  console.log('foo function is exported');
  console.log('====================================');
}

export const bar = () => {
  console.log('======es module=====================');
  console.log('bar function is exported');
  console.log('====================================');
}

export default () => {
  console.log('======es module=====================');
  console.log('This anonymous function is exported as default');
  console.log('====================================');
}


