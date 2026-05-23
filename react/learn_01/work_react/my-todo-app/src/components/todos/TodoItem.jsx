import { Link } from "react-router-dom";
import "./TodoItem.css";

const priorityColors = {
  low: "priority-low",
  medium: "priority-medium",
  high: "priority-high",
};

const priorityLabels = {
  low: "低",
  medium: "中",
  high: "高",
};

export function TodoItem({ todo, onToggle, onDelete }) {
  return (
    <li className={`todo-item ${todo.completed ? "completed" : ""}`}>
      <div className="todo-item-content">
        <input type="checkbox" checked={todo.completed} onChange={() => onToggle(todo.id)} className="todo-checkbox" />

        <div className="todo-details">
          <span className={todo.completed ? "todo-title completed" : "todo-title"}>{todo.title}</span>
          <div className="todo-meta">
            <span className={`priority-badge ${priorityColors[todo.priority]}`}>{priorityLabels[todo.priority]}</span>
            {todo.dueDate && <span className="dut-date">期日: {todo.dueDate}</span>}
          </div>
        </div>

        <div className="todo-actions">
          <Link to={`/todos/${todo.id}/edit`} className="action-btn edit-btn" title="編集">
            ✒️
          </Link>
          <button onClick={() => onDelete(todo.id)} className="action-btn delete-btn" title="削除">
            🗑️
          </button>
        </div>
      </div>
    </li>
  );
}
