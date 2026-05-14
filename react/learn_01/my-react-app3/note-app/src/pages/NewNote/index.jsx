import { useState } from "react"
import { Link, useNavigate } from 'react-router-dom';
import './index.css';
import { ArrowLeft, Save } from 'lucide-react';
import { notesAPI } from "../../lib/api";
import { useNotification } from "../../contexts/NotificationContext";



function NewNote() {
  const [title, setTitle] = useState("")
  const [content, setContent] = useState("")
  const [saving, setSaving] = useState(false)
  const navigate = useNavigate()
  const { showNotification } = useNotification()


  const createNote = async () => {
    // setSaving(true)
    // const data = notesAPI.create({ title, content })
    // console.log(data)
    // navigate("/")
    // setSaving(false)

    setSaving(true)

    try {
      console.log(hoge)
      notesAPI.create({ title, content })
      showNotification("success", "メモを作成しました")
      navigate("/")
    } catch (error) {
      console.log("メモの作成に失敗しました", error)
      showNotification("error", "メモの作成に失敗しました")
    } finally {
      setSaving(false)
    }
  }

  return (
    <div className="new-note">
      <div className="new-note__header">
        <Link className="new-note__back-btn" to="/">
          <ArrowLeft className="new-note__back-icon" /> 戻る
        </Link>

        <div className="new-note__actions">
          <button
            className="new-note__save-btn"
            onClick={ createNote }
            disabled={ !title.trim() || !content.trim() || saving }
          >
            <Save className="new-note__save-icon" />
            { saving ? "保存中..." : "保存" }
          </button>
        </div>
      </div>

      <div className="new-note__content">
        <div className="new-note__meta">
          <div className="new-note__title-container">
            <input
              type="text"
              placeholder="タイトルを入力..."
              className="new-note__title-input"
              value={ title }
              onChange={ (e) => setTitle(e.target.value) }
            />
          </div>
        </div>

        <div className="new-note__editor">
          <textarea
            placeholder="メモの内容を入力してください..."
            className="new-note__textarea"
            value={ content }
            onChange={ (e) => setContent(e.target.value) }
          />
        </div>
      </div>
    </div>
  );
}

export default NewNote;
