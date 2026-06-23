import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { validateTodo } from "../../utils/validate";
import "./TodoForm.css";

export default function TodoForm({ initialValues, onSubmit, submitText = "保存" }) {
    const [values, setValues] = useState(initialValues);
    const [errors, setErrors] = useState({});
    const navigate = useNavigate();

    const handleChange = (e) => {
        const { name, value } = e.target;
        // nameで該当フィールドだけ更新
        setValues(v => ({ ...v, [name]: value }));
    };

    const handleSubmit = (e) => {
        e.preventDefault();                    // 画面リロードを防止
        const errs = validateTodo(values);     // 入力チェック
        setErrors(errs);                       // 画面にエラー表示
        if (Object.keys(errs).length === 0) {  // エラーが無ければ
            onSubmit(values);                  // 親に渡して保存など実行
        }
    };

    return (
        <form onSubmit={handleSubmit} className="todo-form">
            <div className="form-group">
                <label htmlFor="title" className="form-label">
                    タイトル <span className="required">*</span>
                </label>
                <input
                    type="text"
                    id="title"
                    name="title"
                    value={values.title}
                    onChange={handleChange}
                    className={errors.title ? "form-input error" : "form-input"}
                    maxLength="10"
                />
                {errors.title && <span className="error-text">{errors.title}</span>}
            </div>

            <div className="form-group">
                <label htmlFor="detail" className="form-label">
                    詳細
                </label>
                <textarea
                    id="detail"
                    name="detail"
                    value={values.detail}
                    onChange={handleChange}
                    className={errors.detail ? "form-input error" : "form-input"}
                    rows="3"
                    maxLength="50"
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
                />
                {errors.dueDate && <span className="error-text">{errors.dueDate}</span>}
            </div>

            <div className="form-group">
                <label htmlFor="priority" className="form-label">
                    優先度 <span className="required">*</span>
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
                <button type="submit" className="btn-primary">
                    {submitText}
                </button>
                <button
                    type="button"
                    className="btn-secondary"
                    onClick={() => navigate(-1)}
                >
                    キャンセル
                </button>
            </div>
        </form>
    );
}
