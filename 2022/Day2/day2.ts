import input from "./input";

enum Outcome {
    'win',
    'draw',
    'loss'
}

const valueMap = {
    A: 0,
    B: 1,
    C: 2,
    X: 0,
    Y: 1,
    Z: 2
}

const moveMap = {
    0: 'X',
    1: 'Y',
    2: 'Z'
}

const scoringMap = {
    X: 1,
    Y: 2,
    Z: 3,
    0: 6,
    1: 3,
    2: 0 
}

const outcomeMap = {
    X: Outcome.loss,
    Y: Outcome.draw,
    Z: Outcome.win
}

const determineOutcome = (opponentMove: keyof typeof valueMap, myMove: keyof typeof valueMap): Outcome => {
    const opponentValue = valueMap[opponentMove];
    const myValue = valueMap[myMove];

    if ((opponentValue + 1) % 3 == myValue) {
        return Outcome.win
    } else if (opponentValue == myValue) {
        return Outcome.draw
    } else {
        return Outcome.loss
    }
}

const determineMove = (opponentMove: keyof typeof valueMap, outcomeString: keyof typeof outcomeMap): string => {
    const desiredOutcome = outcomeMap[outcomeString];
    const opponentValue = valueMap[opponentMove];
    var myValue: number;
    switch (desiredOutcome) {
        case Outcome.win:
            myValue = (opponentValue + 1) % 3;
            break;
        case Outcome.loss:
            myValue = (opponentValue + 2) % 3;
            break;
        case Outcome.draw:
            myValue = opponentValue;
            break;
        default:
            myValue = opponentValue;
            break;
    }
    return moveMap[myValue as keyof typeof moveMap];
}

const scoreRounds = (moves: string[]): number[] => {
    const scores = moves.map(move => {
        let roundScore = 0;
        const opponentMove = move[0] as keyof typeof valueMap;
        const myMove = move[2] as keyof typeof scoringMap;

        roundScore += scoringMap[myMove];
        const outcome = determineOutcome(opponentMove, myMove as keyof typeof valueMap);
        roundScore += scoringMap[outcome];

        return roundScore;
    });
    return scores;
}

const moves = input.split('\n');

const scores = scoreRounds(moves);
const totalPart1 = scores.reduce((acc, curr) => acc + curr);

const newMoves = moves.map(move => {
    const opponentMove = move[0] as keyof typeof valueMap;
    const desiredOutcome = move[2] as keyof typeof outcomeMap;
    const myMove = determineMove(opponentMove, desiredOutcome);
    return `${opponentMove} ${myMove}`;
});

const newScores = scoreRounds(newMoves);
const totalPart2 = newScores.reduce((acc, curr) => acc + curr);
console.log(totalPart1, totalPart2);