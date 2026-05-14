import { Link, Outlet } from 'react-router-dom';
import './index.css';
import FlashMessage from '../FlashMessage/index';


function Layout() {
  return (
    <div className="layout">
      <header className="layout__header">
        <div className="layout__header-content">
          <div className="layout__logo">
            <Link className="layout__logo-link">
              <h1>NoteSpace</h1>
            </Link>
          </div>
          <nav className="layout__nav">
            <Link className="layout__nav-link" to="/">
              ホーム
            </Link>
            <Link className="layout__nav-link" to="/new">
              新規作成
            </Link>
          </nav>
        </div>
      </header>
      <main className="layout__main">
        <div className="layout__content">
          <Outlet />
        </div>
      </main>

      <FlashMessage />
    </div>
  );
}

export default Layout;
