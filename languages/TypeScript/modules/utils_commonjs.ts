const commonFoo = () => {
  console.log('=========commonjs===========================');
  console.log('commonFoo function is exported');
  console.log('====================================');
}

const commonBar = () => {
  console.log('=========commonjs===========================');
  console.log('commonBar function is exported');
  console.log('====================================');
}

export = {
  commonFoo,
  commonBar
}
