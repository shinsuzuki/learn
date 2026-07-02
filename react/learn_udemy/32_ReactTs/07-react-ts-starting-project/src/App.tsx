import { useState } from "react";
import Todos from "./components/Todos";
import React from "react";
import Todo from "./models/todo";
import NewTodo from "./components/NewTodo";
import { TodosContextProvider } from "./store/todos-context";

function App() {
  //const [todos, setTodos] = useState<Todo[]>([]);

  // const addTodoHandler = (text: string) => {
  //   const newTodo: Todo = {
  //     id: Math.random().toString(),
  //     text: text,
  //   };

  //   setTodos((prevTodos) => {
  //     return [...prevTodos, newTodo];
  //   });
  // };

  // const removeTodoHandler = (todoId: string) => {
  //   console.log(todoId);

  //   setTodos((prevTodos) => {
  //     return prevTodos.filter((todo) => todo.id !== todoId);
  //   });
  // };

  return (
    <TodosContextProvider>
      <NewTodo />
      <Todos />
    </TodosContextProvider>
  );
}

export default App;
