import { useState, useCallback } from "react";

export function useApi() {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const request = useCallback(async (url, options = {}) => {
    setLoading(true);
    setError(null);

    try {
      const response = await fetch(url, {
        headers: {
          "Content-Type": "application/json",
          ...options.headers,
        },
        ...options,
      });

      if (!response.ok) {
        // レスポンスが200番台以外の場合はエラーを投げる
        throw new Error(`APIエラー: ${response.status} ${response.statusText}`);
      }

      const result = await response.json();
      setData(result);
      return result;
    } catch (err) {
      setError(err.message || "予期せぬエラーが発生しました");
      throw err; // コンポーネント側でもエラーを検知できるようにする
    } finally {
      setLoading(false);
    }
  }, []);

  return { data, loading, error, request };
}
