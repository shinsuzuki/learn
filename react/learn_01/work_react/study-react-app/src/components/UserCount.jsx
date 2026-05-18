export function UserCount({ userCount }) {
  const cellStyle = {
    border: "1px solid #222",
    padding: "8px",
    marginTop: "16px",
  }

  const count = userCount

  return <div style={cellStyle}>user-count: {count}</div>
}
