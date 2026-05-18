import { UserTable } from "@/components/UserTable"
import { UserCount } from "@/components/UserCount.jsx"

export function UserList() {
  const containerStyle = {
    border: "2px solid #222",
    borderRadius: "10px",
    width: "400px",
    margin: "40px auto",
    padding: "24px",
    background: "#fff",
  }

  const users = [
    { id: 1, name: "taro yamada", age: 20 },
    { id: 2, name: "hanako yamada", age: 21 },
  ]

  return (
    <div style={containerStyle}>
      <UserTable users={users} />
      <UserCount userCount={users.length} />
    </div>
  )
}
