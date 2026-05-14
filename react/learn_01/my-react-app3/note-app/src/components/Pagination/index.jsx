import { ChevronLeft, ChevronRight } from 'lucide-react';
import './index.css';

function Pagination() {
  return (
    <div className="pagination">
      <button className="pagination__nav">
        <ChevronLeft className="pagination__nav-icon" />
        前へ
      </button>

      <div className="pagination__info">
        1 / 2
      </div>

      <button className="pagination__nav">
        次へ
        <ChevronRight className="pagination__nav-icon" />
      </button>
    </div>
  );
}

export default Pagination;
