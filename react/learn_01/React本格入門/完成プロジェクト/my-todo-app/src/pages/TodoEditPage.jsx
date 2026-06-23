import { useParams, useNavigate } from "react-router-dom";
import { useTodos } from "../context/TodoContext";
import TodoForm from "../components/todos/TodoForm";
import "./TodoEditPage.css";

export default function TodoEditPage() {
    const { id } = useParams();
    const { getTodo, updateTodo } = useTodos();
    const navigate = useNavigate();

    // IDからTodoを取得
    const todo = getTodo(id);

    // Todoが見つからない場合
    if (!todo) {
        return (
            <div className="todo-edit-page">
                <h2 className="page-title">エラー</h2>
                <p className="error-message">指定されたTodoが見つかりませんでした。</p>
                <button
                    onClick={() => navigate("/todos")}
                    className="btn-primary"
                >
                    一覧へ戻る
                </button>
            </div>
        );
    }

    // 初期値（既存のTodoデータ）
    const initialValues = {
        title: todo.title || "",
        detail: todo.detail || "",
        dueDate: todo.dueDate || "",
        priority: todo.priority || "medium",
    };

    // フォーム送信時の処理
    const handleSubmit = (values) => {
        updateTodo(id, values);
        // 一覧ページへ遷移（成功メッセージ付き）
        navigate("/todos", { state: { message: "更新しました" } });
    };

    return (
        <div className="todo-edit-page">
            <h2 className="page-title">Todo編集</h2>
            <TodoForm
                initialValues={initialValues}
                onSubmit={handleSubmit}
                submitText="更新"
            />
        </div>
    );
}
