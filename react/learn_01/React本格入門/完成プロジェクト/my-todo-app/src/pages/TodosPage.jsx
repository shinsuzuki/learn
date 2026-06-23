import { useState, useEffect } from "react";
import { useLocation } from "react-router-dom";
import { useTodos } from "../context/TodoContext";
import TodoList from "../components/todos/TodoList";
import ConfirmDialog from "../components/common/ConfirmDialog";
import "./TodosPage.css";

export default function TodosPage() {
    // TodoContextから必要な機能を取得（todos配列、完了状態の切り替え、削除機能）
    const { todos, toggleComplete, removeTodo } = useTodos();
    // 削除対象のTodoを保存する状態（nullなら削除ダイアログは表示されない）
    const [deleteTarget, setDeleteTarget] = useState(null);
    // 成功メッセージを表示するための状態
    const [successMessage, setSuccessMessage] = useState("");
    // 現在のページの場所情報を取得（他のページからの遷移時の情報を受け取るため）
    const location = useLocation();

    // ナビゲーション時のstateから成功メッセージを取得
    useEffect(() => {
        // 他のページから遷移してきた時にメッセージが設定されているかチェック
        if (location.state?.message) {
            setSuccessMessage(location.state.message);

            // stateをクリアして、戻るボタンでメッセージが再表示されるのを防ぐ
            // ブラウザの履歴を書き換えてstateを削除
            window.history.replaceState({}, '', location.pathname);
        }
    }, [location.state, location.pathname]);

    // メッセージを3秒後に自動で消す
    useEffect(() => {
        // successMessageが設定されている場合のみ実行
        if (successMessage) {
            // 3秒後にメッセージを消すタイマーを設定
            const timer = setTimeout(() => {
                setSuccessMessage("");
            }, 3000);
            // コンポーネントがアンマウントされた時や
            // successMessageが変更された時にタイマーをクリア
            // （クリーンアップ関数）
            return () => clearTimeout(timer);
        }
    }, [successMessage]);

    // 削除ダイアログを開く関数
    const handleDeleteClick = (id) => {
        const todo = todos.find(t => t.id === id);
        // 削除対象として状態に保存（これによりダイアログが表示される）
        setDeleteTarget(todo);
    };

    // 削除を実行する関数
    const handleDeleteConfirm = () => {
        if (deleteTarget) {
            // TodoContextのremoveTodo関数を呼び出して実際に削除
            removeTodo(deleteTarget.id);
            // 削除ダイアログを閉じる
            setDeleteTarget(null);
            // 削除完了メッセージを表示
            setSuccessMessage("削除しました");
            // 3秒後にメッセージを消す
            setTimeout(() => {
                setSuccessMessage("");
            }, 3000);
        }
    };

    // 削除をキャンセルする関数
    const handleDeleteCancel = () => {
        // 削除対象をクリアしてダイアログを閉じる
        setDeleteTarget(null);
    };

    return (
        <div className="todos-page">
            <h2 className="page-title">Todo一覧</h2>

            {/* 成功メッセージがある場合のみ表示される条件付きレンダリング */}
            {successMessage && (
                <div className="success-message">
                    <span>{successMessage}</span>
                    {/* メッセージを手動で閉じるボタン */}
                    <button
                        onClick={() => setSuccessMessage("")}
                        className="message-close-btn"
                        type="button"
                    >
                        ×
                    </button>
                </div>
            )}

            {/* Todo一覧コンポーネント（props経由でデータと関数を渡す） */}
            <TodoList
                todos={todos}
                onToggle={toggleComplete}
                onDelete={handleDeleteClick}
            />

            {/* 確認ダイアログコンポーネント */}
            <ConfirmDialog
                open={!!deleteTarget} /* deleteTargetがnullでない場合にtrueになる */
                title="削除の確認"
                /* オプショナルチェイニング（?.）でnullエラーを防ぐ */
                message={`「${deleteTarget?.title}」を削除してもよろしいですか？`}
                onConfirm={handleDeleteConfirm}
                onCancel={handleDeleteCancel}
            />
        </div>
    );
}
