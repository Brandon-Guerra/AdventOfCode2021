import { input, test } from "./input";

type Point = [number, number];

const motions = input.split("\n").map((motion) => motion.split(" "));

let headPosition: Point = [0, 0];
let position1: Point = [0, 0];
let position2: Point = [0, 0];
let position3: Point = [0, 0];
let position4: Point = [0, 0];
let position5: Point = [0, 0];
let position6: Point = [0, 0];
let position7: Point = [0, 0];
let position8: Point = [0, 0];
let tailPosition: Point = [0, 0];

const tailPositions = new Set<string>();

const movePoint = (point: Point, direction: string): Point => {
  switch (direction) {
    case "U":
      point[1] += 1;
      break;
    case "D":
      point[1] -= 1;
      break;
    case "L":
      point[0] -= 1;
      break;
    case "R":
      point[0] += 1;
      break;
    default:
      break;
  }
  return point;
};

const followPoint = (to: Point, from: Point): Point => {
  const [x1, y1] = from;
  const [x2, y2] = to;
  // touching
  if (x1 - 1 <= x2 && x2 <= x1 + 1 && y1 - 1 <= y2 && y2 <= y1 + 1) {
    return from;
  }
  let destinationPoint = from;
  if (x1 < x2) {
    destinationPoint = movePoint(destinationPoint, "R");
  }
  if (x1 > x2) {
    destinationPoint = movePoint(destinationPoint, "L");
  }
  if (y1 < y2) {
    destinationPoint = movePoint(destinationPoint, "U");
  }
  if (y1 > y2) {
    destinationPoint = movePoint(destinationPoint, "D");
  }
  return destinationPoint;
};

motions.forEach((motion) => {
  const [direction, steps] = motion;
  for (let index = 0; index < Number(steps); index++) {
    headPosition = movePoint(headPosition, direction);
    position1 = followPoint(headPosition, position1);
    position2 = followPoint(position1, position2);
    position3 = followPoint(position2, position3);
    position4 = followPoint(position3, position4);
    position5 = followPoint(position4, position5);
    position6 = followPoint(position5, position6);
    position7 = followPoint(position6, position7);
    position8 = followPoint(position7, position8);
    tailPosition = followPoint(position8, tailPosition);
    tailPositions.add(tailPosition.toString());
  }
});

console.log(tailPositions.size);
