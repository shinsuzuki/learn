import { useState, useEffect } from "react";
import { useLocation } from "react-router-dom";
import { useTodos } from "@/context/TodoContext";
import { TodoList } from "@/components/todos/TodoList";
import { ConfirmDialog } from "@/components/common/ConfirmDialog";
import "./TodosPage.css";

export function TodosPage() {
  const { todos, toggleComplete, removeTodo } = useTodos();
  const [deleteTarget, setDeleteTarget] = useState(null);
  const [successMessage, setSuccessMessage] = useState("");
  const location = useLocation();

  useEffect(() => {
    if (location.state?.successMessage) {
      setSuccessMessage(location.state.successMessage);
      window.history.replaceState({}, "", location.pathname);
    }
  }, [location.state, location.pathname]);

  useEffect(() => {
    if (successMessage) {
      const timer = setTimeout(() => {
        setSuccessMessage("");
      }, 3000);

      return () => clearTimeout(timer);
    }
  }, [successMessage]);

  const handleDeleteClick = (id) => {
    const todo = todos.find((t) => t.id === id);
    if (todo) {
      setDeleteTarget(todo);
    }
  };

  const handleDeleteConfirm = () => {
    if (deleteTarget) {
      removeTodo(deleteTarget.id);
      setDeleteTarget(null);
      setSuccessMessage("削除しました");
      setTimeout(() => {
        setSuccessMessage("");
      }, 3000);
    }
  };

  const handleDeleteCancel = () => {
    setDeleteTarget(null);
  };

  return (
    <div className="todos-page">
      <h2 className="page-title">TODO一覧</h2>
      {successMessage && (
        <div className="success-message">
          <span>{successMessage}</span>
          <button className="messge-close-btn" type="button" onClick={() => setSuccessMessage("")}>
            ✕
          </button>
        </div>
      )}

      <TodoList todos={todos} onToggle={toggleComplete} onDelete={handleDeleteClick} />

      <ConfirmDialog
        open={!!deleteTarget}
        title="削除確認"
        message={`${deleteTarget?.title}を削除しますか？`}
        onConfirm={handleDeleteConfirm}
        onCancel={handleDeleteCancel}
      />
    </div>
  );
}
