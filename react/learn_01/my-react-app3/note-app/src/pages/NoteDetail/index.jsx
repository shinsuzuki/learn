import { ArrowLeft, Save, Trash2, Calendar, Clock } from 'lucide-react';
import './index.css';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { useEffect, useState } from 'react';
import { notesAPI } from '../../lib/api';
import { useNotification } from '../../contexts/NotificationContext';
import Spinner from '../../components/Spinner/index';

function NoteDetail() {
  const { id } = useParams();
  const [note, setNote] = useState(null)
  const [loading, setLoading] = useState(true)
  const { showNotification } = useNotification();
  const navigate = useNavigate();
  const [title, setTitle] = useState('')
  const [content, setContent] = useState('')
  const [saving, setSaving] = useState(false)


  useEffect(() => {
    fetchNote()
  }, [])

  const fetchNote = async () => {

    setLoading(true)
    try {
      const note = await notesAPI.getByID(id)
      setNote(note)
      setTitle(note.title)
      setContent(note.content)
    } catch (error) {
      console.error(error)
      showNotification('error', 'メモの取得に失敗しました')
      navigate('/')
    } finally {
      setLoading(false)
    }
  }

  if (loading) {
    return <div className="note-detail">
      <Spinner />
    </div>
  }

  const updateNote = async () => {
    setSaving(true)
    try {
      await notesAPI.update(id, { title, content })
      showNotification('success', 'メモを更新しました')
      navigate('/')
    } catch (error) {
      console.error(`エラーが発生しました: ${error}`)
      showNotification('error', 'メモの更新に失敗しました')
    } finally {
      setSaving(false)
    }
  }

  const deleteNote = async () => {
    if (!window.confirm("メモを削除しますか?")) {
      return
    }

    try {
      await notesAPI.delete(id)
      showNotification('success', 'メモを削除しました')
      navigate('/')
    } catch (error) {
      console.error(`エラーが発生しました: ${error}`)
      showNotification('error', 'メモの削除に失敗しました')
    } finally {
      setSaving(false)
    }
  }


  return (
    <div className="note-detail">
      <div className="note-detail__header">
        <Link className="note-detail__back-btn" to="/">
          <ArrowLeft className="note-detail__back-icon" /> 戻る
        </Link>
        <div className="note-detail__actions">
          <button
            className="note-detail__save-btn"
            onClick={ updateNote }
            disabled={ !title.trim() || !content.trim() || saving }
          >
            <Save className="note-detail__save-icon" />
            { saving ? "保存中..." : "保存" }
          </button>
          <button className="note-detail__action-btn note-detail__action-btn--danger" onClick={ deleteNote }>
            <Trash2 className="note-detail__action-icon" />
          </button>
        </div>
      </div>
      <div className="note-detail__content">
        <div className="note-detail__meta">
          <input
            type="text"
            className="note-detail__title-input"
            placeholder="タイトルを入力..."
            value={ title }
            onChange={ (e) => setTitle(e.target.value) }
          />
          <div className="note-detail__info">
            <div className="note-detail__info-item">
              <Calendar className="note-detail__info-icon" />
              作成: { note.createdAt }
            </div>
            <div className="note-detail__info-item">
              <Clock className="note-detail__info-icon" />
              更新: { note.updatedAt }
            </div>
          </div>
        </div>
        <div className="note-detail__body">
          <textarea
            className="note-detail__textarea"
            placeholder="メモの内容を入力してください..."
            value={ content }
            onChange={ (e) => setContent(e.target.value) }
          />
        </div>
      </div>
    </div>
  );
}

export default NoteDetail;
