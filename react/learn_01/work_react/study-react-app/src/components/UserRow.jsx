export function UserRow(props) {
  // const id = 1
  // const name = "taro yamada"
  // const age = 33

  const cellStyle = {
    border: "1px solid #222",
    padding: "8px",
    textAlign: "cneter",
  }

  return (
    <tr>
      <td style={cellStyle}>{props.id}</td>
      <td style={cellStyle}>{props.name}</td>
      <td style={cellStyle}>{props.age}</td>
    </tr>
  )
}
