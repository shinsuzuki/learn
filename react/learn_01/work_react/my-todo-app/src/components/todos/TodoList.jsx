import { TodoItem } from "@/components/todos/TodoItem";
import "./TodoItem.css";

export function TodoList({ todos, onToggle, onDelete }) {
  if (todos.length === 0) {
    return (
      <div className="empty-state">
        <p className="empty-message">todo がありません</p>
        <p className="empty-sub">新規ボタンから追加してください</p>
      </div>
    );
  }

  return (
    <ul className="todo-list">
      {todos.map((todo) => (
        <TodoItem key={todo.id} todo={todo} onToggle={onToggle} onDelete={onDelete} />
      ))}
    </ul>
  );
}
