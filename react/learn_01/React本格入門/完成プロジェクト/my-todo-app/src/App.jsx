import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { TodoProvider } from "./context/TodoContext";
import AppLayout from "./components/layout/AppLayout";
import TodosPage from "./pages/TodosPage";
import TodoNewPage from "./pages/TodoNewPage";
import TodoEditPage from "./pages/TodoEditPage";
import "./App.css";

function App() {
  return (
    <TodoProvider>
      <BrowserRouter>
        <AppLayout>
          <Routes>
            <Route path="/" element={<Navigate to="/todos" replace />} />
            <Route path="/todos" element={<TodosPage />} />
            <Route path="/todos/new" element={<TodoNewPage />} />
            <Route path="/todos/:id/edit" element={<TodoEditPage />} />
          </Routes>
        </AppLayout>
      </BrowserRouter>
    </TodoProvider>
  );
}

export default App;
