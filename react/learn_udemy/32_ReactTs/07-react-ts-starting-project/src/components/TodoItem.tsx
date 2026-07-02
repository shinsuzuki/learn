import classes from "./TodoItem.module.css";

function TodoItem({
  text,
  onRemoveTodo,
}: {
  text: string;
  onRemoveTodo: () => void;
}) {
  return (
    <li className={classes.item} onClick={onRemoveTodo}>
      {text}
    </li>
  );
}

export default TodoItem;
