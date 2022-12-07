import buffer from "./input";

const characters = buffer.split("");
const set = new Set();
for (let index = 0; index < characters.length; index++) {
  set.add(characters.slice(index, index + 14));
  if (set.size == 14) {
    console.log(index + 14);
    break;
  }
  console.log(set, "\n");
  set.delete(characters[index]);
}
