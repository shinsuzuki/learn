import { useState } from 'react'
import "./App.css"
import TodoList from './components/TodoList';

export default function App() {
  const [todos, setTodos] = useState([
    { id: 1, text: "第3章を復習する", completed: false },
    { id: 2, text: "TODO1アプリを完成させる", completed: true }
  ]);

  const [input, setInput] = useState("")
  const [error, setError] = useState("")
  const [filter, setFilter] = useState("active")

  const addTodo = () => {
    const text = input.trim()
    if (text) {
      setTodos([
        ...todos,
        { id: Date.now(), text: text, completed: false }])

      setInput("")
    } else {
      setError("入力してください")
      return
    }

  }

  const toggleId = (id) => {
    setTodos(
      todos.map((todo) => {
        if (todo.id === id) {
          return { ...todo, completed: !todo.completed }
        } else {
          return todo
        }
      })
    )
  }

  const deleteTodo = (id) => {
    setTodos(todos.filter((todo) => todo.id !== id))
  }


  const getFilterdTodos = () => {
    if (filter === "active") {
      return todos.filter((todo) => !todo.completed)
    } else if (filter === "completed") {
      return todos.filter((todo) => todo.completed)
    } else {
      return todos
    }
  }

  const filteredTodos = getFilterdTodos()

  const activateCount = todos.filter((todo) => !todo.completed).length
  const completedCount = todos.filter((todo) => todo.completed).length



  return (
    <>
      <div className="app">
        <h1>TODO アプリ</h1>

        <div className="todo-form">
          <input
            id="todo-input"
            type="text"
            value={ input }
            onChange={ (e) => setInput(e.target.value) }
            placeholder='new todo'
            className="todo-input"
          />

          <button type="submit" className="add-button" onClick={ addTodo }>追加</button>
          { error && <p className="error-message">{ error }</p> }

          {/* <ul className="todo-list">
            { todos.map((todo) => (
              <li key={ todo.id } className={ todo.completed ? 'completed' : '' }>
                <input type="checkbox" checked={ todo.completed } onChange={ () => toggleId(todo.id) } />
                <span>{ todo.text }</span>
                <button onClick={ () => deleteTodo(todo.id) }>delete</button>
              </li>
            )) }

          </ul> */}
          <div className="filter-buttons">
            <button className={ filter === "active" ? "active" : "" } onClick={ () => setFilter("active") }>未完了 ({ activateCount })</button>
            <button className={ filter === "completed" ? "active" : "" } onClick={ () => setFilter("completed") }>完了 ({ completedCount })</button>
            <button className={ filter === "all" ? "active" : "" } onClick={ () => setFilter("all") }>すべて ({ todos.length })</button>
          </div>

          <TodoList todos={ filteredTodos } onToggle={ toggleId } onDelete={ deleteTodo } />

        </div>
      </div >
    </>
  )
}








