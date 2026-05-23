import { useNavigate } from "react-router-dom";
import { useTodos } from "@/context/TodoContext";
import { TodoForm } from "@/components/todos/TodoForm";
import "./TodoNewPage.css";

export function TodoNewPage() {
  const { addTodo } = useTodos();
  const navigate = useNavigate();

  const initialValues = {
    title: "",
    detail: "",
    dueDate: "",
    priority: "medium",
  };

  const handleSubmit = (values) => {
    addTodo(values);
    navigate("/todos", { state: { message: "新規TODOを追加しました" } });
  };

  return (
    <div className="todo-new-page">
      <h2 className="page-title">TODO新規作成</h2>
      <TodoForm intialValues={initialValues} onSubmit={handleSubmit} submitText="新規作成" />
    </div>
  );
}
