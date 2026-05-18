import { UserRow } from "./UserRow"

export function UserTable({ users }) {
  const tableStyle = {
    borderCollapse: "collapse",
    width: "100%",
    margin: "auto",
  }

  const thStyle = {
    border: "1px solid #222",
    padding: "8px",
    background: "black",
  }

  return (
    <table style={tableStyle}>
      <thead>
        <tr>
          <th style={thStyle}>id</th>
          <th style={thStyle}>name</th>
          <th style={thStyle}>age</th>
        </tr>
      </thead>
      <tbody>
        {users.map((user) => (
          <UserRow key={user.id} id={user.id} name={user.name} age={user.age} />
        ))}
      </tbody>
    </table>
  )
}
