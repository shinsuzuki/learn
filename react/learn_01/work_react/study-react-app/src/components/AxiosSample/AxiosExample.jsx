import { useEffect, useState } from "react";
import axios from "axios";

export function AxiosExample() {
  const [users, setUsers] = useState([]);
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");

  const baseUrl = "http://localhost:3001/users";

  const fetchUsers = async () => {
    try {
      const response = await axios.get(baseUrl);
      setUsers(response.data);
    } catch (error) {
      console.error(error);
    }
  };

  const addUser = async () => {
    try {
      const newUser = { name, email };
      await axios.post(baseUrl, newUser);
      setName("");
      setEmail("");
      fetchUsers();
    } catch (error) {
      console.error(error);
    }
  };

  const updateUser = async () => {
    try {
      await axios.put(`${baseUrl}/1`, {
        name: "update_name",
        email: "update_email",
      });

      fetchUsers();
    } catch (error) {
      console.error(error);
    }
  };

  const deteLastUser = async () => {
    if (users.length <= 0) return;
    const lastUserID = users[users.length - 1].id;

    try {
      await axios.delete(`${baseUrl}/${lastUserID}`);
      fetchUsers();
    } catch (error) {
      console.log(error);
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  return (
    <>
      <h2>Axios</h2>
      <div>
        <input type="text" value={name} onChange={(e) => setName(e.target.value)} />
        <input type="text" value={email} onChange={(e) => setEmail(e.target.value)} />
        <button onClick={addUser}>ユーザー追加</button>
      </div>
      <hr />
      <button onClick={updateUser}>ユーザー更新</button>
      <button onClick={deteLastUser}>ユーザー削除</button>
      <hr />
      <ul>
        {users.map((user) => (
          <li key={user.id}>
            {user.name} - {user.email}
          </li>
        ))}
      </ul>
    </>
  );
}
