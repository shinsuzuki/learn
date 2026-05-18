import { useState } from "react";

export function FormApp() {
  const [formData, setFormData] = useState({ userName: "", userMail: "" });
  const [submittedlist, setSubmittedlist] = useState([]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    setSubmittedlist([...submittedlist, formData]);
    setFormData({ userName: "", userMail: "" });
  };

  return (
    <div>
      <h2>user input form </h2>
      <form onSubmit={handleSubmit}>
        <div>
          <label>name:</label>
          <input type="text" name="userName" value={formData.userName} onChange={handleChange} required />
          <div></div>
          <label>mail:</label>
          <input type="email" name="userMail" value={formData.userMail} onChange={handleChange} required />
        </div>
        <button type="submit">登録</button>';
      </form>

      <h3>登録ユーザーリスト</h3>
      <ul>
        {submittedlist.map((user, index) => (
          <li key={index}>
            {user.userName} ({user.userMail})
          </li>
        ))}
      </ul>
    </div>
  );
}
