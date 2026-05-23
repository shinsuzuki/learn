import { useParams, useNavigate } from "react-router-dom";
import { useTodos } from "@/context/TodoContext";
import { TodoForm } from "@/components/todos/TodoForm";
import "./TodoEditPage.css";

export function TodoEditPage() {
  const { id } = useParams();
  const { getTodo, updateTodo } = useTodos();
  const navigate = useNavigate();

  const todo = getTodo(id);

  console.log(`todo: ${JSON.stringify(todo)}`);

  if (!todo) {
    return (
      <div className="todo-edit-page">
        <h2 className="page-title">エラー</h2>
        <p className="error-message">TODOが見つかりません</p>
        <button onClick={() => navigate("todos/")} className="btn-primary">
          一覧へ戻る
        </button>
      </div>
    );
  }

  const initialValues = {
    title: todo.title || "",
    detail: todo.detail || "",
    dueDate: todo.dueDate || "",
    priority: todo.priority || "medium",
  };

  const handleSubmit = (values) => {
    updateTodo(id, values);
    navigate("/todos", { state: { message: "TODOを更新しました" } });
  };

  return (
    <div className="todo-edit-page">
      <h2 className="page-title">TODO編集</h2>
      <TodoForm intialValues={initialValues} onSubmit={handleSubmit} submitText="更新" />
    </div>
  );
}
