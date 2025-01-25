import { HubConnection, HubConnectionBuilder } from '@microsoft/signalr';
import { createContext, ReactNode, useContext, useEffect, useRef, useState } from 'react';
import { APP_ENV } from '../../../../constants/env';
import { useAppSelector } from '../../../../redux';
import { getToken } from '../../../../redux/slices/userSlice';

interface SignalRContextType {
    connection: HubConnection | null | undefined;
}

const SignalRContext = createContext<SignalRContextType | null>(null);

export const SignalRProvider: React.FC<{ children: ReactNode | ReactNode[] }> = ({ children }) => {
    const token = useAppSelector(getToken)
    const [signalRConnection, setSignalConnection] = useState<HubConnection | null | undefined>();
    const signaConnectionRef = useRef<HubConnection | null | undefined>();

    const tabCloseListener = async () => {
        if (signaConnectionRef) {
            try {
                await signaConnectionRef.current?.invoke("Disconnect");
                signaConnectionRef.current?.stop()
            } catch (error) {
                console.error("Error while disconnecting:", error);
            }
        }
    }

    const closeSignalConnection = () => {
        signalRConnection?.stop();
        setSignalConnection(null)
        signaConnectionRef.current = null;
    }

    useEffect(() => {
        (async () => {
            if (token) {
                const signaConnection = new HubConnectionBuilder()
                    .withUrl(`${APP_ENV.SERVER_HOST}/hub`, {
                        accessTokenFactory: () =>  token || ""
                    })
                    .withAutomaticReconnect()
                    .build();

                try {
                    await signaConnection?.start();
                    await signaConnection?.invoke('Connect')
                    signaConnection?.onclose(() => {
                        window.removeEventListener("beforeunload", tabCloseListener);
                    })
                    window.addEventListener("beforeunload", async () => {
                        tabCloseListener();
                    });

                } catch (err) {
                    console.log(err);
                }
                setSignalConnection(signaConnection)
                signaConnectionRef.current = signaConnection;
            }
            else {
                closeSignalConnection();
            }
        })()

        return () => {
            signalRConnection?.stop();
        };

    }, [token])

    return (
        <SignalRContext.Provider value={{ connection: signalRConnection }}>
            {children}
        </SignalRContext.Provider>
    );
};

export const useSignalR = (): SignalRContextType | null | undefined => {
    const context = useContext(SignalRContext);
    if (!context) {
        console.log('useSignalR must be used within a SignalRProvider');
    }
    return context;
}