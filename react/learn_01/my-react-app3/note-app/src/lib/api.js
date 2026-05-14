const baseUrl = "http://localhost:3001"

const defaultOption = {
  headers: {
    'content-type': 'application/json'
  }
}

const apiFetch = async (url, options) => {
  return await fetch(
    `${baseUrl}/${url}`, {
    ...defaultOption,
    ...options,
  })
}

export const notesAPI = {
  async getAll() {
    const result = await apiFetch('notes', {
      method: 'GET'
    })

    if (!result.ok) {
      throw new Error(`メモ一覧の取得に失敗しました: ${result.status}`)
    }

    return result.json()
  },
  async create(data) {
    const result = await apiFetch('notes', {
      method: 'POST',
      body: JSON.stringify(data)
    });

    if (!result.ok) {
      throw new Error(`メモの作成に失敗しました: ${result.status}`)
    }

    return result.json()
  },
  async getByID(id) {
    const result = await apiFetch(`notes/${id}`, {
      method: 'GET'
    })

    if (!result.ok) {
      throw new Error(`メモの取得に失敗しました: ${result.status}`)
    }

    return result.json();
  },
  async update(id, data) {
    const result = await apiFetch(`notes/${id}`, {
      method: 'PUT',
      body: JSON.stringify(data)
    })

    if (!result.ok) {
      throw new Error(`メモの更新に失敗しました: ${result.status}`)
    }
    return result.json()
  },
  async delete(id) {
    const result = await apiFetch(`notes/${id}`, {
      method: 'DELETE',
    })

    if (!result.ok) {
      throw new Error(`メモの削除に失敗しました: ${result.status}`)
    }

    return result.json()
  }

}