import { input, test } from "./input";

interface Monkey {
  number: number;
  items: number[];
  inspectionCount: number;
  divisibleBy: number;
  operation: (input: number) => number;
  throwTo: (input: number) => number;
}

const notes = input.split("\n\n");

const postInspectionModifier = (worryLevel: number): number => {
  return Math.floor(worryLevel / 3);
};

const getOperation = (line: string[]): ((num: number) => number) => {
  /* LCM of divisible by numbers, which is just their product
  because they are all prime numbers */
  switch (line[1]) {
    case "+":
      return (num: number) => {
        const rhs = line[2] == "old" ? num : Number(line[2]);
        return (num + rhs) % reducer;
      };
    case "*":
      return (num: number) => {
        const rhs = line[2] == "old" ? num : Number(line[2]);
        return (num * rhs) % reducer;
      };
    default:
      throw Error(`Could not create operation with ${line}`);
  }
};

const monkeys: Monkey[] = [];
const part2Monkeys: Monkey[] = [];

notes.forEach((monkeyNote) => {
  const lines = monkeyNote.split("\n");
  const number = Number(lines[0].split(" ")[1].slice(0, -1));
  const items = lines[1]
    .split(":")[1]
    .split(", ")
    .map((item) => Number(item));
  const operationLine = lines[2].split("= ")[1].split(" ");
  const operation = getOperation(operationLine);
  const divisibleBy = Number(lines[3].split("by ")[1]);
  const ifTrue = Number(lines[4].split("monkey ")[1]);
  const ifFalse = Number(lines[5].split("monkey ")[1]);
  const throwTo = (input) => {
    return input % divisibleBy == 0 ? ifTrue : ifFalse;
  };
  const monkey: Monkey = {
    items,
    number,
    inspectionCount: 0,
    divisibleBy,
    operation,
    throwTo,
  };
  monkeys.push(monkey);
  part2Monkeys.push(monkey);
});

const reducer = monkeys
  .map((monkey) => monkey.divisibleBy)
  .reduce((acc, curr) => acc * curr);

// const rounds = 20;
// for (let index = 0; index < rounds; index++) {
//   monkeys.forEach((monkey) => {
//     monkey.inspectionCount += monkey.items.length;
//     monkey.items.forEach((item, index) => {
//       monkey.items[index] = monkey.operation(item);
//       monkey.items[index] = postInspectionModifier(monkey.items[index]);
//       const throwTo = monkey.throwTo(monkey.items[index]);
//       monkeys
//         .find((monkey) => monkey.number == throwTo)
//         ?.items.push(monkey.items[index]);
//     });
//     // all items should be thrown after inspecting items
//     monkey.items = [];
//   });
// }
// const part1 = monkeys
//   .map((monkey) => monkey.inspectionCount)
//   .sort((a, b) => a - b)
//   .slice(-2)
//   .reduce((acc, curr) => acc * curr, 1);

// console.log(part1);

const part2Rounds = 10000;
for (let index = 0; index < part2Rounds; index++) {
  part2Monkeys.forEach((monkey) => {
    monkey.inspectionCount += monkey.items.length;
    monkey.items.forEach((item, index) => {
      monkey.items[index] = monkey.operation(item);
      const throwTo = monkey.throwTo(monkey.items[index]);
      part2Monkeys
        .find((monkey) => monkey.number == throwTo)
        ?.items.push(monkey.items[index]);
    });
    // all items should be thrown after inspecting items
    monkey.items = [];
  });
}

const part2 = part2Monkeys
  .map((monkey) => monkey.inspectionCount)
  .sort((a, b) => a - b)
  .slice(-2)
  .reduce((acc, curr) => acc * curr, 1);

console.log(part2);
