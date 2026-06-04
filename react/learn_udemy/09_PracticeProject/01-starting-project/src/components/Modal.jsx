import { useRef, useImperativeHandle } from "react";
import { createPortal } from "react-dom";
import Button from "./Button";

export default function Modeal({ children, buttonCaption, ref }) {
  const modalDialogRef = useRef();

  useImperativeHandle(ref, () => {
    return {
      open() {
        modalDialogRef.current.showModal();
      },
    };
  });

  return createPortal(
    <dialog
      ref={modalDialogRef}
      className="backdrop:bg-stone-900/90 p-4 rounded-md shadow-md"
    >
      {children}
      <form method="dialog" className="mt-4 text-right">
        <Button>{buttonCaption}</Button>
      </form>
    </dialog>,
    document.getElementById("modal-root"),
  );
}
