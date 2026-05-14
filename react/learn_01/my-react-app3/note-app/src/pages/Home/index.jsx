import { useEffect, useState } from "react"
import NoteCard from '../../components/NoteCard/index';
import Pagination from '../../components/Pagination/index';
import './index.css';
import { Search, ShowerHeadIcon } from 'lucide-react';
import Spinner from '../../components/Spinner/index';
import { notesAPI } from "../../lib/api";
import { useNotification } from "../../contexts/NotificationContext";


function Home() {
  const [notes, setNotes] = useState([])
  const [loading, setLoading] = useState(true)
  const { showNotification } = useNotification()


  const fetchNotes = async () => {
    setLoading(true)
    try {
      const data = await notesAPI.getAll()
      console.log(data)
      setNotes(data.notes)
    } catch (error) {
      console.log("メモの取得に失敗しました", error)
      showNotification('error', "メモの取得に失敗しました")
    } finally {
      setLoading(false)
    }

  }

  const getContents = () => {
    if (loading) {
      return (
        <div className="home__notes home__notes--loading">
          <Spinner />
        </div>
      )
    }

    const deleteNote = async (id) => {
      if (!window.confirm("メモを削除しますか?")) {
        return
      }

      try {
        await notesAPI.delete(id)
        await fetchNotes()
        showNotification('success', 'メモを削除しました')
      } catch (error) {
        console.error(`エラーが発生しました: ${error}`)
        showNotification('error', 'メモの削除に失敗しました')
      }
    }

    return (
      <div className="home__notes">
        { notes.map((note) => (<NoteCard key={ note.id } note={ note } onDelete={ deleteNote } />)) }
      </div>
    )
  }

  useEffect(() => {
    fetchNotes()
  }, [])

  return (
    <div className="home">
      <div className="home__search">
        <div className="home__search-input">
          <Search className="home__search-icon" />
          <input
            type="text"
            placeholder="メモを検索..."
            className="home__search-field"
          />
          <button className="home__search-btn">
            検索
          </button>
        </div>
      </div>
      { getContents() }
      <Pagination />
    </div>
  );
}

export default Home;
