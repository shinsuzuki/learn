import './index.css';
import { useNotification } from "../../contexts/NotificationContext"

function FlashMessage() {
  const { notification } = useNotification()
  if (!notification) return null

  return (
    <div className={ `flash-message flash-message--${notification.type}` }>
      <span className="flash-message__text">{ notification.message }</span>
    </div>
  )
}

export default FlashMessage;
