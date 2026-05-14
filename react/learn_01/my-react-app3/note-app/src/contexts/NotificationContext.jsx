import { createContext, useContext, useState, useEffect } from 'react'

const NotificationContext = createContext(null)

// カスタムフック
const useNotification = () => {
    const context = useContext(NotificationContext)
    if (!context) {
        throw new Error("useNotification must be used within a NotificationProvider")
    }

    return context
}


const NotificationProvider = ({ children }) => {
    const [notification, setNotification] = useState(null)

    const showNotification = (type, message) => {
        setNotification({ type, message })
    }

    useEffect(() => {
        if (notification) {
            const timer = setTimeout(() => {
                setNotification(null)
            }, 3000)

            return () => {
                clearTimeout(timer)
            }
        }
    }, [notification])

    return (<NotificationContext.Provider value={ { notification, showNotification } }>
        { children }
    </NotificationContext.Provider>)

}

export { NotificationProvider, useNotification }
