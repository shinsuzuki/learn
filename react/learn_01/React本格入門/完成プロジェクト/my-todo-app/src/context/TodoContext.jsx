import { createContext, useContext, useEffect, useState } from "react";

const STORAGE_KEY = "app.todos";
const TodoContext = createContext(null);

export function TodoProvider({ children }) {
    // 初期化時にlocalStorageから読み込み
    const [todos, setTodos] = useState(() => {
        try {
            const raw = localStorage.getItem(STORAGE_KEY);
            return raw ? JSON.parse(raw) : [];
        } catch (e) {
            return [];
        }
    });

    // todos が変わるたびに localStorage に保存
    useEffect(() => {
        try {
            localStorage.setItem(STORAGE_KEY, JSON.stringify(todos));
        } catch (e) {
            console.error("ローカルストレージへの保存に失敗しました:", e);
        }
    }, [todos]);

    // CRUD処理
    // 追加
    function addTodo(newTodo) {
        setTodos((prev) => {
            const todoWithId = {
                ...newTodo,
                id: `t_${Date.now()}`, // 一意なIDを生成
                completed: false,      // 追加時は未完了
            };
            return [todoWithId, ...prev];
        });
    }

    // 更新（対象だけを置き換え）
    function updateTodo(id, patch) {
        setTodos((prev) =>
            prev.map((t) => (t.id === id ? { ...t, ...patch } : t)) // 三項演算子で分岐
        );
    }

    // 削除（id が一致するものだけ除外）
    function removeTodo(id) {
        setTodos((prev) => prev.filter((t) => (t.id === id ? false : true)));
    }

    // 完了フラグの反転
    function toggleComplete(id) {
        setTodos((prev) =>
            prev.map((t) =>
                t.id === id ? { ...t, completed: !t.completed } : t
            )
        );
    }

    // 1件取得（見つからなければ undefined）
    function getTodo(id) {
        return todos.find((t) => (t.id === id ? true : false));
    }

    // Contextに配る値
    const value = {
        todos,
        addTodo,
        updateTodo,
        removeTodo,
        toggleComplete,
        getTodo,
    };

    // Providerで全コンポーネントに渡す
    return (
        <TodoContext.Provider value={value}>
            {children}
        </TodoContext.Provider>
    );
}

// カスタムフック（Contextを安全に取り出す用）
export function useTodos() {
    const ctx = useContext(TodoContext);
    if (ctx === null) {
        throw new Error("useTodos は TodoProvider の内側で使ってください");
    }
    return ctx;
}
