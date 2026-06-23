import { Outlet, Link } from "react-router-dom";

function Dashboard() {
    return (
        <div>
            <h1>ダッシュボード</h1>
            <nav>
                <ul>
                    <li><Link to="profile">プロフィール</Link></li>
                    <li><Link to="settings">設定</Link></li>
                </ul>
            </nav>

            {/* 子ルートのコンポーネントがここに表示される */}
            <Outlet />
        </div>
    );
}

export default Dashboard;
