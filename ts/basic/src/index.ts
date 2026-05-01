// let hello: string = "hello";
// console.log(hello);
// 定数の定義に方は書かず、型推論に任せる
let hasValue: boolean = true;
let count: number = 10;
let single: string = "hello";

// 関数の引数は型を指定する
function func1(name: string) {
  return name;
}

// 外部とやり取りするデータモデル(DTO、エンティティ)のは型を指定する


// 配列はこう書く
const fruits: string[] = ["Apple", "Banana", "Grape"];

// tuple
const books: [string, number, boolean] = ["business", 1500, false];

// enum
enum CoffeeSize {
  SHORT = "SHORT",
  TALL = "TALL",
  GRANDE = "GRANDE",
  VENTI = "VENTI",
}

console.log(CoffeeSize.SHORT)

// any なんでもOK、まあ使わない
let anything: any = true;
anything = "hello";

// union
let unionType: number | string = 10;
unionType = "hello";

type Status = "success" | "error" | "loading";
let status2: Status = "success";
console.log(status2)

// リテラル型
const apple: 'apple' = "apple"
let banana: "ban1" | "ban2" = "ban1"
banana = "ban2"

// type
type ClothSize = "small" | "medium" | "large";
let clothSize: ClothSize = "large";


type CoffeeCup = {
  shots: number;
  hasMilk: boolean;
}

let cup: CoffeeCup =
{
  shots: 2,
  hasMilk: true,
}

// function
function add(n1: number, n2: number): number {
  return n1 + n2;
}

function hello(): void {
  console.log("hello");
}


let add2: (n1: number, n2: number) => number;
add2 = add
console.log(add2(1, 2))

const add3 = (x: number, y: number): number => {
  return x + y;
}
console.log(add3(1, 2))

function add4(value: number, cb: (num: number) => number): number {
  return value + cb(value)
}

console.log(add4(2, x => x + x))


// unknown,何でも入れられが使うときは型をチェックして使う
let aaa: unknown = "str1"
aaa = "str2"
// aaa = 1
let bbb: string = typeof (aaa) === "string" ? aaa : "str3"
console.log(bbb)

// satifies
28 satisfies number;
//28 satisfies string;

// never ほとんど、例外の時くらいか。


// クラス
class Person {
  private name: string;
  public age: number = 30;
  #p_data = 0;
  constructor(name: string) {
    this.name = name;
  }

  greet(this: Person) {
    console.log(`Hello, my name is ${this.name}`);
  }
}

let person = new Person("Alice");
person.greet()


class Hero {
  constructor(public name: string, public age: number) { }

  attack(this: Hero): void {
    console.log(`attack: ${this.name}`);
  }
}

let hero = new Hero("sato", 30)
hero.attack();


class SuperHero extends Hero {
  #moto = ""
  constructor(public attr: string, public name: string, public age: number) {
    super(name, age)
  }

  get moto() {
    return this.#moto
  }

  set moto(value) {
    this.#moto = value
  }
}

let shero = new SuperHero("strength", "sato", 30)
shero.attack()


// interace
interface Human {
  name: string;
  age: number;
  greeting(message: string): void;
}

class Developer implements Human {
  constructor(public name: string, public age: number) { }
  greeting(message: string) {
    console.log(message);
  }
}


type Monster = {
  name: string;
  age: number;
}


type Enemy = {
  name: string;
  age: number;
} & Monster;

let enemy: Enemy = {
  name: "sato",
  age: 30,
}

console.log(enemy.name)
console.log(enemy.age)





