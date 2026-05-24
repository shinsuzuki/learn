console.log(">> start");

//---------- array
const fruits = ["apple", "orange", "banana"];

const customFruits = fruits.map((item) => {
  return item + "!";
});
console.log(customFruits);

const customFruits2 = fruits.map((item) => item + "!");
console.log(customFruits2);

const customFruits3 = fruits.map((item) => {
  return { text: item };
});
console.log(customFruits3);

const customFruits4 = fruits.map((item) => ({ text: item }));
console.log(customFruits4);

const [fn, ln] = ["FirstName", "LastName"];
console.log(fn, ln);

const user = {
  name: "sato",
  age: 33,
};

const { name: userName, age } = {
  name: "sato",
  age: 33,
};

console.log(userName, age);

const newFruits = ["ichigo"];
const fruits2 = [...fruits, ...newFruits];
console.log(fruits2);

const extendUser = {
  isAdmin: true,
  ...user,
};
console.log(extendUser);

fruits2.forEach((item) => {
  console.log(item);
});

for (const item of fruits2) console.log(item);

console.log(">> end");
