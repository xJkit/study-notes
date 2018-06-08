/**
 * Inheritance
 */

class Person {
  name: string;

  constructor(name: string) {
    this.name = name;
  }

  dance() {
    console.log('====================================');
    console.log(`${this.name} is dancing...`);
    console.log('====================================');
  }
}


const Jay = new Person('Jay Chung');

Jay.dance(); // Jay Chung is dancing...

/** extends */

class Hero extends Person {
  dance() {
    console.log('====================================');
    console.log(`Hero ${this.name} is dancing amazing!!!`);
    console.log('====================================');
  }

  superDance() {
    super.dance();
  }
}

const Faye = new Hero('Faye Lin');
Faye.dance(); // Hero Faye Lin is dancing amazing!!!
Faye.superDance(); // Faye Lin is dancing...

export {}
