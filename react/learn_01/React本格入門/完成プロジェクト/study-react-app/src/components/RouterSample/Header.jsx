import { Link } from "react-router-dom";

function Header() {
    return (
        <nav>
            <Link to="/">🏠ホーム🔗</Link> |
            <Link to="/about">📖このサイトについて🔗</Link> |
            <Link to="/contact">📞お問い合わせ🔗</Link>
        </nav>
    );
}

export default Header;