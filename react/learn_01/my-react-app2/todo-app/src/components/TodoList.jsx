
function TodoList({ todos, onToggle, onDelete }) {
    if (todos.length <= 0) {
        return <p className="empty-state">タスクがありません。</p>
    }

    return (
        <ul className="todo-list">
            { todos.map((todo) => (
                <li key={ todo.id } className={ todo.completed ? 'completed' : '' }>
                    <input
                        type="checkbox"
                        checked={ todo.completed }
                        onChange={ () => onToggle(todo.id) }
                    />
                    <span>{ todo.text }</span>
                    <button onClick={ () => onDelete(todo.id) }>delete</button>
                </li>
            )) }

        </ul>

    )
}

export default TodoList;