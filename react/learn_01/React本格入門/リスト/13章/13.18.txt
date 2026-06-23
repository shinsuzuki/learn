import "./ConfirmDialog.css";

export default function ConfirmDialog({ open, title, message, onConfirm, onCancel }) {
    if (!open) return null;

    return (
        <>
            <div className="dialog-overlay" onClick={onCancel} />
            <div className="dialog-container">
                <div className="dialog-header">
                    <h2 className="dialog-title">{title}</h2>
                </div>
                <div className="dialog-content">
                    <p className="dialog-message">{message}</p>
                </div>
                <div className="dialog-actions">
                    <button onClick={onCancel} className="btn-secondary">
                        キャンセル
                    </button>
                    <button onClick={onConfirm} className="btn-danger">
                        削除
                    </button>
                </div>
            </div>
        </>
    );
}
