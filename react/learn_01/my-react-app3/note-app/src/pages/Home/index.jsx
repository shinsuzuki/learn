import { useEffect, useState } from "react"
import NoteCard from '../../components/NoteCard/index';
import Pagination from '../../components/Pagination/index';
import './index.css';
import { Search, ShowerHeadIcon } from 'lucide-react';
import Spinner from '../../components/Spinner/index';
import { notesAPI } from "../../lib/api";
import { useNotification } from "../../contexts/NotificationContext";
import { useSearchParams } from "react-router-dom";

function Home() {
  const [notes, setNotes] = useState([])
  const [totalPages, setTotalPages] = useState(0)
  const [searchParams, setSearchParams] = useSearchParams()
  const [loading, setLoading] = useState(true)
  const { showNotification } = useNotification()

  const currentPage = parseInt(searchParams.get('page') || 1, 10)
  console.log(`currentPage: ${currentPage}`)

  const keyword = searchParams.get('search') || ''
  console.log(`search: ${keyword}`)

  const [inputValue, setInputValue] = useState(keyword)

  const handleSearch = () => {
    setSearchParams({ page: 1, search: inputValue.trim() })
  }

  const fetchNotes = async () => {
    try {
      setLoading(true)
      const data = await notesAPI.getAll({ page: currentPage, search: keyword })
      console.log(data)
      setNotes(data.notes)
      setTotalPages(data.pagination.totalPages)
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

    if (notes.length === 0) {
      return (
        <div className="home__notes home__notes--loading">
          <p>メモがありません。</p>
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

  const moveToPage = (page) => {
    setSearchParams({ page: page.toString() })
  }

  useEffect(() => {
    fetchNotes()
  }, [currentPage, keyword])

  return (
    <div className="home">
      <div className="home__search">
        <div className="home__search-input">
          <Search className="home__search-icon" />
          <input
            type="text"
            placeholder="メモを検索..."
            className="home__search-field"
            value={ inputValue }
            onChange={ (e) => setInputValue(e.target.value) }
          />
          <button className="home__search-btn" onClick={ handleSearch }>
            検索
          </button>
        </div>
      </div>
      { getContents() }
      <Pagination currentPage={ currentPage } onPageChange={ moveToPage } totalPage={ totalPages } />
    </div>
  );
}

export default Home;
