import { input, test } from "./input";

const cycles = input.split("\n");

const values = cycles.map((cycle) => {
  if (cycle == "noop") {
    return 0;
  } else {
    const [, v] = cycle.split(" ");
    return Number(v);
  }
});

const getValueAtCyle = (values: number[], cycleNumber: number): number => {
  let cycle = 1;
  let total = 1;
  values.forEach((value) => {
    if (cycle < cycleNumber) {
      total += value;
      if (value == 0) {
        cycle += 1;
      } else {
        cycle += 2;
      }
    }
  });
  return total * cycleNumber;
};

const cycleNumbers = [20, 60, 100, 140, 180, 220];

const part1 = cycleNumbers
  .map((cycleNumber) => getValueAtCyle(values, cycleNumber))
  .reduce((acc, curr) => acc + curr);

console.log(part1);

let cycleNumber = 1;
var screen = "";
let value = 1;
for (let index = 0; index < 240; index++) {
  const scaledValue = (index + 1) % 40;
  if (
    value == scaledValue ||
    value - 1 == scaledValue ||
    value + 1 == scaledValue
  ) {
    screen += "#";
  } else {
    screen += ".";
  }
  if (cycleNumber % 40 == 0) {
    screen += "\n";
  }
  cycleNumber += 1;
  value = getValueAtCyle(values, cycleNumber) / cycleNumber;
}

console.log(screen);
