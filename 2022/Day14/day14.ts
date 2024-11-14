import scan from "./input";

enum Tile {
  "sand",
  "rock",
  "empty",
}

const paths = scan.split("\n");
let cave;

for (let index = 0; index < paths.length; index++) {
  const path = paths[index].split(" -> ");
  for (let j = 0; j < path.length; j++) {
    const subPath = path[j];
    const [left, right] = subPath.split(",");
    cave[left][right] = Tile.rock;
  }
}

console.log(cave[531][159]);
