import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { validateTodo } from "@/utils/validate";
import "./TodoForm.css";

export function TodoForm({ intialValues, onSubmit, submitText = "保存" }) {
  const [values, setValues] = useState(intialValues);
  const [errors, setErrors] = useState({});
  const navigate = useNavigate();

  const handleChange = (e) => {
    const { name, value } = e.target;
    setValues((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const errs = validateTodo(values);
    setErrors(errs);
    console.log(`errs: ${JSON.stringify(errs)}`);

    if (Object.keys(errs).length === 0) {
      onSubmit(values);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="todo-form">
      <div className="form-group">
        <label htmlFor="title" className="form-label">
          タイトル
          <span className="required">*</span>
        </label>
        <input
          type="text"
          id="title"
          name="title"
          value={values.title}
          onChange={handleChange}
          className={errors.title ? "form-input error" : "form-input"}
          max-length="10"
        />
        {errors.title && <span className="error-text">{errors.title}</span>}
      </div>
      <div className="form-group">
        <label htmlFor="detail" className="form-label">
          詳細
        </label>
        <input
          type="text"
          id="detail"
          name="detail"
          value={values.detail}
          onChange={handleChange}
          className={errors.detail ? "form-input error" : "form-input"}
          max-length="10"
          raw="3"
        />
        {errors.detail && <span className="error-text">{errors.detail}</span>}
      </div>

      <div className="form-group">
        <label htmlFor="dueDate" className="form-label">
          期日
        </label>
        <input
          type="date"
          id="dueDate"
          name="dueDate"
          value={values.dueDate}
          onChange={handleChange}
          className={errors.dueDate ? "form-input error" : "form-input"}
          max-length="10"
          raw="3"
        />
        {errors.dueDate && <span className="error-text">{errors.dueDate}</span>}
      </div>

      <div className="form-group">
        <label htmlFor="priority" className="form-label">
          優先度<span className="required">*</span>
        </label>
        <select
          id="priority"
          name="priority"
          value={values.priority}
          onChange={handleChange}
          className={errors.priority ? "form-input error" : "form-input"}
        >
          <option value="">選択してください</option>
          <option value="low">低</option>
          <option value="medium">中</option>
          <option value="high">高</option>
        </select>

        {errors.priority && <span className="error-text">{errors.priority}</span>}
      </div>

      <div className="form-actions">
        <button type="submit" className="btn btn-primary">
          {submitText}
        </button>
        <button type="button" className="btn-sedondary" onClick={() => navigate(-1)}>
          キャンセル
        </button>
      </div>
    </form>
  );
}
