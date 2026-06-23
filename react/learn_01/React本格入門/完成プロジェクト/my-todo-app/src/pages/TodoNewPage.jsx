import { useNavigate } from "react-router-dom";
import { useTodos } from "../context/TodoContext";
import TodoForm from "../components/todos/TodoForm";
import "./TodoNewPage.css";

export default function TodoNewPage() {
    const { addTodo } = useTodos();
    const navigate = useNavigate();

    // 初期値
    const initialValues = {
        title: "",
        detail: "",
        dueDate: "",
        priority: "medium",
    };

    // フォーム送信時の処理
    const handleSubmit = (values) => {
        addTodo(values);
        // 一覧ページへ遷移（成功メッセージ付き）
        navigate("/todos", { state: { message: "登録しました" } });
    };

    return (
        <div className="todo-new-page">
            <h2 className="page-title">新規Todo作成</h2>
            <TodoForm
                initialValues={initialValues}
                onSubmit={handleSubmit}
                submitText="登録"
            />
        </div>
    );
}
