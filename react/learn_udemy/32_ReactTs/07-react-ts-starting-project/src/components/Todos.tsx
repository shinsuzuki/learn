import React from "react";
import Todo from "../models/todo";
import TodoItem from "./TodoItem";
import { TodosContext } from "../store/todos-context";
import classes from "./Todos.module.css";

function Todos() {
  const todosCtx = React.useContext(TodosContext);

  return (
    <ul className={classes.todos}>
      {todosCtx.items.map((item) => (
        <TodoItem
          key={item.id}
          text={item.text}
          //onRemoveTodo={onRemoveTodo.bind(null, item.id)}
          onRemoveTodo={() => todosCtx.removeTodo(item.id)}
        />
      ))}
    </ul>
  );
}

export default Todos;
