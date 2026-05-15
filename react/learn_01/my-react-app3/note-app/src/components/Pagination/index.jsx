import { ChevronLeft, ChevronRight } from 'lucide-react';
import './index.css';

function Pagination({ currentPage, onPageChange, totalPage }) {
  if (totalPage < 1) {
    return null
  }

  return (
    <div className="pagination">
      <button className="pagination__nav" onClick={ () => onPageChange(currentPage - 1) } disabled={ currentPage === 1 }>
        <ChevronLeft className="pagination__nav-icon" />
        前へ
      </button>

      <div className="pagination__info">
        { currentPage } / { totalPage }
      </div>

      <button className="pagination__nav" onClick={ () => onPageChange(currentPage + 1) } disabled={ currentPage === totalPage }>
        次へ
        <ChevronRight className="pagination__nav-icon" />
      </button>
    </div>
  );
}

export default Pagination;
