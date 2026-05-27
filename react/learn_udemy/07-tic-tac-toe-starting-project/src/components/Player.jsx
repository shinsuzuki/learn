import { useState } from "react";

export default function Player({ initialName, symbol, isActive, onChangeName }) {
  const [playerName, setPlayerName] = useState(initialName);
  const [playerSymbol, setPlayerSymbol] = useState(symbol);
  //
  const [isEditing, setIsEditing] = useState(false);

  let editablePlayerName = <span className="player-name">{playerName}</span>;

  if (isEditing) {
    editablePlayerName = (
      <input type="text" required value={playerName} onChange={handleChangName}></input>
    );
  }

  function handleEditClick() {
    setIsEditing((editing) => !editing);

    if (isEditing) {
      onChangeName(symbol, playerName);
    }
  }

  function handleChangName(e) {
    setPlayerName(e.target.value);
  }

  return (
    <li className={isActive ? "active" : undefined}>
      <span className="player">
        {editablePlayerName}
        <span className="player-symbol">{playerSymbol}</span>
        <button onClick={handleEditClick}>{isEditing ? "Save" : "Edit"}</button>
      </span>
    </li>
  );
}
