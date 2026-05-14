import { BrowserRouter, Routes, Route } from 'react-router-dom'
import Layout from './components/Layout/index'
import Home from './pages/Home/index'
import NewNote from './pages/NewNote/index'
import NoteDetail from './pages/NoteDetail/index'
import { NotificationProvider } from './contexts/NotificationContext'
import './App.css'

function App() {

  return (
    <NotificationProvider>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={ <Layout /> }>
            <Route index element={ <Home /> } />
            <Route path="/new" element={ <NewNote /> } />
            <Route path="/notes/:id" element={ <NoteDetail /> } />
          </Route>
        </Routes>
      </BrowserRouter >
    </NotificationProvider>
  )
}

export default App
