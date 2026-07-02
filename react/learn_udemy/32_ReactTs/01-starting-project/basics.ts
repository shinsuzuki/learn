type Person = {
  name: string;
  age: number;
};

let person: Person;

person = {
  name: "Max",
  age: 30,
};

console.log(person.name);

function add(a: number, b: number): number {
  return a + b;
}
