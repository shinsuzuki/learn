import { Link } from 'react-router-dom';
import './index.css';
import { Trash2 } from 'lucide-react';

function NoteCard({ note, onDelete }) {

  const handleDelete = (e) => {
    e.preventDefault()
    onDelete(note.id)
  }


  return (
    <Link className="note-card-link" to={ `/notes/${note.id}` }>
      <div className="note-card">
        <div className="note-card__content">
          <h3 className="note-card__title">{ note.title }</h3>
          <p className="note-card__body">{ note.content }</p>
        </div>
        <div className="note-card__footer">
          <span className="note-card__date">{ note.updatedAt }</span>
          <div className="note-card__actions">
            <button className="note-card__delete" onClick={ handleDelete }>
              <Trash2 className="note-card__icon" />
            </button>
          </div>
        </div>
      </div>
    </Link>
  );
}

export default NoteCard;
