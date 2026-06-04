import { useState } from "react";

export default function NewTask({ onAdd }) {
  const [enteredTask, setEnteredTask] = useState("");

  function handleChange(e) {
    setEnteredTask(e.target.value);
  }

  function onClick() {
    if (enteredTask.trim().length === 0) {
      return;
    }
    onAdd(enteredTask);
    setEnteredTask("");
  }

  return (
    <div className="flex items-cneter gap-4">
      <input
        type="text"
        placeholder="new task"
        className="w-64 px-2 py-1 rounded-sm bg-stone-200"
        onChange={handleChange}
        value={enteredTask}
      />
      <button className="text-stone-700 hover:text-stone-950" onClick={onClick}>
        Add Task
      </button>
    </div>
  );
}
