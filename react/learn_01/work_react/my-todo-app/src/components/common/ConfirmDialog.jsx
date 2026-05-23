import "./ConfirmDialog.css";

export function ConfirmDialog({ open, title, message, onConfirm, onCancel }) {
  if (!open) return null;

  return (
    <>
      <div className="dialog-overlay">
        <div className="dialog-container">
          <div className="dialog-header">
            <h2 className="dialog-title">{title}</h2>
          </div>
          <div className="dialog-content">
            <p className="dialog-message">{message}</p>
          </div>
          <div className="dialog-actions">
            <button className="btn-secondary" onClick={onCancel}>
              Cancel
            </button>
            <button className="btn-danger" onClick={onConfirm}>
              削除
            </button>
          </div>
        </div>
      </div>
    </>
  );
}
