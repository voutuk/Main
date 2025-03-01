import React, { useEffect } from 'react'
import { addMessage, getAuth } from '../../../../redux/slices/userSlice';
import { useAppDispatch, useAppSelector } from '../../../../redux';
import { IAdminMesssage } from '../../../../models/adminMesssage';
import { adminMessageAuthApi } from '../../../../redux/api/adminMessageApi';
import { useSignalR } from '../signalRContext';




const SignalRListener: React.FC = () => {
    const dispatcher = useAppDispatch();
    const { isUser, isAuth } = useAppSelector(getAuth)
    const signalRConnection = useSignalR();
    useEffect(() => {
        if (isAuth) {
            (async () => {
                if (isUser) {
                    signalRConnection?.connection?.on('ReceiveAdminMessage', (message: IAdminMesssage) => {
                        dispatcher(addMessage(message))
                        dispatcher(adminMessageAuthApi.util.invalidateTags(['Messeges']))
                    });
                }
                else {
                    signalRConnection?.connection?.on('ReceiveUserMessage', (message: IAdminMesssage) => {
                        dispatcher(addMessage(message))
                        dispatcher(adminMessageAuthApi.util.invalidateTags(['Messeges']))
                    });
                }
            })()
        }
    }, [signalRConnection?.connection]);

    return null;
}

export default SignalRListener


