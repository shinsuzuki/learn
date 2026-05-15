import './App.css'

function Profile({ name, age }: { name: string; age: number }) {
  return (
    <>
      <h1>name: { name }</h1>
      <p>age: { age }</p>
    </>
  )
}

function App() {
  return (
    <>
      <Profile name="sato" age={ 22 } />
    </>
  )
}

export default App
