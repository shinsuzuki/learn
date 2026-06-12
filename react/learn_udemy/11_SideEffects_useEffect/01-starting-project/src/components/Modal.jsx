import { useRef, useEffect } from "react";
import { createPortal } from "react-dom";

function Modal({ open, onClose, children }) {
  const dialogRef = useRef();

  useEffect(() => {
    if (open) {
      dialogRef.current.showModal();
    } else {
      dialogRef.current.close();
    }
  }, [open]);

  return createPortal(
    <dialog className="modal" ref={dialogRef} onClose={onClose}>
      {open ? children : null}
    </dialog>,
    document.getElementById("modal"),
  );
}

export default Modal;
