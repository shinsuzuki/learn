// import { useState } from 'react';
import { useState, useEffect } from 'react';
import './App.css'

function App() {
  console.log("コンポーネントがレンダリングされました。")
  const [count, setCounmt] = useState(0);


  useEffect(() => {
    console.log(`count updated: ${count}`)
  }, [count]);

  const proeuctNames = ["notepc", "keyboard", "mouse", "iphone"]

  return (
    <>
      <p>count:{ count }</p>
      <button onClick={ () => setCounmt(count + 1) }>+</button>

      <ul>
        {
          proeuctNames.map((name) => (
            <li key={ name }>{ name }</li>
          ))
        }
      </ul>

    </>
  )
}

export default App
