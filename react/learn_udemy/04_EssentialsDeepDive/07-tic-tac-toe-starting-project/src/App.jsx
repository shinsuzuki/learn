import { useState } from "react";
import Player from "./components/Player.jsx";
import GameBoard from "./components/GameBoard.jsx";
import Log from "./components/Log.jsx";
import { WINNING_COMBINATIONS } from "./winning-combinations.js";
import GameOver from "./components/GameOver.jsx";

const INITIAL_GAME_BOARD = [
  ["", "", ""],
  ["", "", ""],
  ["", "", ""],
];

function App() {
  const [players, setPlayers] = useState({ X: "player-1", O: "player-2" });
  const [gameTurns, setGameTurns] = useState([]);
  //const [activePlayer, setActivePlayer] = useState("X");

  function deriveGameBoard(gameTurns) {
    let gameBoard = [...INITIAL_GAME_BOARD.map((array) => [...array])];

    for (const turn of gameTurns) {
      const { square, player } = turn;
      const { row, col } = square;
      gameBoard[row][col] = player;
    }
    return gameBoard;
  }

  function derivedActivePlayer(gameTruns) {
    let currentPlayer = "X";

    if (gameTruns.length > 0 && gameTruns[0].player === "X") {
      currentPlayer = "O";
    }
    return currentPlayer;
  }

  function deriveWinner(gameBoard, players) {
    let winner = "";

    for (const combination of WINNING_COMBINATIONS) {
      //console.log(combination);
      const firstSquareSymbol = gameBoard[combination[0].row][combination[0].column];
      const secondSquareSymbol = gameBoard[combination[1].row][combination[1].column];
      const thirdSquareSymbol = gameBoard[combination[2].row][combination[2].column];

      if (
        firstSquareSymbol &&
        firstSquareSymbol === secondSquareSymbol &&
        firstSquareSymbol === thirdSquareSymbol
      ) {
        winner = players[firstSquareSymbol];
      }
    }

    return winner;
  }

  const activePlayer = derivedActivePlayer(gameTurns);
  const gameBoard = deriveGameBoard(gameTurns);
  const winner = deriveWinner(gameBoard, players);
  const hasDraw = gameTurns.length === 9 && !winner;

  function handleRestart() {
    setGameTurns([]);
    //setActivePlayer("X");
  }

  function handleSelectSquare(rowIndex, colIndex) {
    // setActivePlayer((player) => (player === "X" ? "O" : "X"));

    setGameTurns((prevTurns) => {
      const currentPlayer = derivedActivePlayer(prevTurns);
      //console.log(`currentPlayer: ${currentPlayer}`);

      const updatedTurns = [
        { square: { row: rowIndex, col: colIndex }, player: currentPlayer },
        ...prevTurns,
      ];
      //console.log(updatedTurns);

      return updatedTurns;
    });
  }

  function handlePlayerNameChange(symbol, newName) {
    console.log(symbol, newName);
    setPlayers((prevPlayers) => {
      return { ...prevPlayers, [symbol]: newName };
    });
  }

  return (
    <main>
      <div id="game-container">
        <ol id="players" className="highlight-player">
          <Player
            initialName="player-1"
            symbol="X"
            isActive={activePlayer === "X"}
            onChangeName={handlePlayerNameChange}
          />
          <Player
            initialName="player-2"
            symbol="O"
            isActive={activePlayer === "O"}
            onChangeName={handlePlayerNameChange}
          />
        </ol>
        {(winner || hasDraw) && <GameOver winner={winner} onRestart={handleRestart} />}
        <GameBoard onSelectSquare={handleSelectSquare} board={gameBoard} />
      </div>
      <Log turns={gameTurns} />
    </main>
  );
}

export default App;
