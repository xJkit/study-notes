/** Basic Types Demo */

const isWinter: boolean = false;

const count: number = 1234;

const name: string = 'Jay Chung';

const names: string[] = ['Jay', 'Faye', 'Can', 'Jim'];

enum HttpMethods {
  GET,
  POST,
  DELETE,
  PATCH,
  HEAD
}

const response: HttpMethods = HttpMethods.POST;

function countChar(chars: string): number {
  return chars.length;
}

countChar('Jay Chung');

export {};
