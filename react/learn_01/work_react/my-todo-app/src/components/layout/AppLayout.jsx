import { Link } from "react-router-dom";
import "@/components/layout/AppLayout.css";

export function AppLayout({ children }) {
  return (
    <>
      <header className="app-header">
        <div className="header-content">
          <h1 className="header-title">📓 TODO Manager</h1>
          <nav className="header-nav">
            <Link to="/todos" className="nav-link">
              一覧
            </Link>
            <Link to="/todos/new" className="nav-link">
              新規
            </Link>
          </nav>
        </div>
      </header>

      <main className="main-container">
        <div className="content-wrapper">{children}</div>
      </main>
    </>
  );
}
