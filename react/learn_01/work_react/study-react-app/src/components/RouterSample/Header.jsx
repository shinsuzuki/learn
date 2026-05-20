import { Link } from "react-router-dom";

export function Header() {
  return (
    <nav>
      <Link to="/">home</Link> |<Link to="/about">about</Link> |<Link to="/contact">contact</Link>
    </nav>
  );
}
