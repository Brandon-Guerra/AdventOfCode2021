import day3Input from "./input";

const rucksacks = day3Input.split("\n");
const commonItems = rucksacks.map(rucksack => {
    const leftCompartment = new Set(rucksack.slice(0, rucksack.length / 2));
    const rightCompartment = new Set(rucksack.slice(rucksack.length / 2, rucksack.length + 1));

    var setLength = leftCompartment.size;

    for (let item of rightCompartment) {
        leftCompartment.add(item);
        if (leftCompartment.size == setLength) {
            return item;
        } else {
            setLength = leftCompartment.size;
        }
    }
});

const charToPriorityValue = (char: string): number => {
    const charCode = char.charCodeAt(0);
    if (charCode >= 97 ) {
        return charCode - 96;
    } else {
        return charCode - 38;
    }
}

const part1 = commonItems.reduce((acc, curr) => acc += charToPriorityValue(curr!), 0);
console.log(part1);

const setsOfThree: string[][] = [];
for (let index = 0; index < rucksacks.length; index+=3) {
    setsOfThree.push(rucksacks.slice(index, index + 3));
}

const commonsOfThree = setsOfThree.map(set => {
    const setOne = new Set(set[0]);
    const setTwo = new Set(set[1]);
    const setThree = new Set(set[2]);

    const intersectionOne = new Set([...setOne].filter(element => setTwo.has(element)));
    const intersectionTwo = new Set([...intersectionOne].filter(element => setThree.has(element)));
    return [...intersectionTwo][0];
});

const part2 = commonsOfThree.reduce((acc, curr) => acc += charToPriorityValue(curr!), 0);