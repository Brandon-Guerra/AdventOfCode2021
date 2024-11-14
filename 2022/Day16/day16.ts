import { input, test } from "./input";
var Graph = require("graph-data-structure");

interface Valve {
  name: string;
  flowRate: number;
  connections: string[];
  pressureAtTime?: number;
  pressureRelease: (flowRate: number, time: number) => number;
}

const selectValve = (name: string): Valve => {
  // Non-null assertion ok here since leads to values will always be in input
  return valves.find((valve) => valve.name == name)!;
};

const createGraph = (valves: Valve[]): typeof Graph => {
  var time = 30;
  var graph = Graph();
  valves.forEach((valve) => {
    graph.addNode(JSON.stringify(valve));
  });
  valves.forEach((valve) => {
    valve.connections.forEach((connection) => {
      console.log(connection);
      console.log(valve.flowRate, " ", time);
      valve.pressureAtTime = valve.pressureRelease(valve.flowRate, time);
      graph.addEdge(
        JSON.stringify(valve),
        JSON.stringify(selectValve(connection)),
        valve.pressureAtTime
      );
      if ((time -= 1) == 0) {
        return;
      }
    });
  });
  return graph;
};

const valves = test.split("\n").map((valveInput) => {
  var connections = valveInput.split("to valve")[1].split(", ");
  if (connections[0].includes("s")) {
    connections[0] = connections[0].replace("s ", "");
  } else {
    connections[0] = connections[0].trim();
  }
  const valve: Valve = {
    name: valveInput.substring(6, 8),
    flowRate: Number(
      valveInput.substring(valveInput.indexOf("=") + 1, valveInput.indexOf(";"))
    ),
    connections,
    pressureRelease: (flowRate, time) => {
      return flowRate * time;
    },
  };
  return valve;
});

const valveGraph = createGraph(valves);
console.log(valveGraph.nodes().map((string) => JSON.parse(string)));
// console.log(
//   valveGraph
//     .shortestPath(
//       valveGraph
//         .nodes()
//         .find((nodeString) => JSON.parse(nodeString).name == "AA"),
//       valveGraph
//         .nodes()
//         .find((nodeString) => JSON.parse(nodeString).name == "FF")
//     )
//     .map((string) => JSON.parse(string))
// );

console.log("done");
