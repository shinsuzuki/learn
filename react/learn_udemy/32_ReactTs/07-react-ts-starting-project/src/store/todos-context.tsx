import { createContext, useState } from "react";
import Todo from "../models/todo";

type TodosContextObj = {
  items: Todo[];
  addTodo: (text: string) => void;
  removeTodo: (id: string) => void;
};

export const TodosContext = createContext<TodosContextObj>({
  items: [],
  addTodo: (text: string) => {},
  removeTodo: (id: string) => {},
});

export const TodosContextProvider = (props: any) => {
  const [todos, setTodos] = useState<Todo[]>([]);

  const addTodoHandler = (text: string) => {
    const newTodo: Todo = {
      id: Math.random().toString(),
      text: text,
    };

    setTodos((prevTodos) => {
      return [...prevTodos, newTodo];
    });
  };

  const removeTodoHandler = (todoId: string) => {
    console.log(todoId);

    setTodos((prevTodos) => {
      return prevTodos.filter((todo) => todo.id !== todoId);
    });
  };

  const contextValue: TodosContextObj = {
    items: todos,
    addTodo: addTodoHandler,
    removeTodo: removeTodoHandler,
  };

  return (
    <TodosContext.Provider value={contextValue}>
      {props.children}
    </TodosContext.Provider>
  );
};
