import { createContext, useContext, useEffect, useState } from "react";

const STORAGE_KEY = "app.todos";
const TodoContext = createContext();

export function TodoProvider({ children }) {
  const [todos, setTodos] = useState(() => {
    try {
      const raw = localStorage.getItem(STORAGE_KEY);
      return raw ? JSON.parse(raw) : [];
    } catch (e) {
      return [];
    }
  });

  useEffect(() => {
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify(todos));
    } catch (e) {
      console.error("localstorageへの保存に失敗しました:", e);
    }
  }, [todos]);

  function addTodo(newTodo) {
    setTodos((prev) => {
      const todoWithId = {
        ...newTodo,
        id: `t_${Date.now()}`,
        completed: false,
      };
      return [todoWithId, ...prev];
    });
  }

  function updateTodo(id, patch) {
    setTodos((prev) => prev.map((t) => (t.id === id ? { ...t, ...patch } : t)));
  }

  function removeTodo(id) {
    setTodos((prev) => prev.filter((t) => (t.id === id ? false : true)));
  }

  function toggleComplete(id) {
    setTodos((prev) => prev.map((t) => (t.id === id ? { ...t, completed: !t.completed } : t)));
  }

  function getTodo(id) {
    return todos.find((t) => t.id === id);
  }

  const value = {
    todos,
    addTodo,
    updateTodo,
    removeTodo,
    toggleComplete,
    getTodo,
  };

  return <TodoContext.Provider value={value}>{children}</TodoContext.Provider>;
}

// eslint-disable-next-line react-refresh/only-export-components
export function useTodos() {
  const ctx = useContext(TodoContext);

  if (ctx === null) {
    throw new Error("useTodoはTodoProviderの内側で使用してください");
  }

  return ctx;
}
