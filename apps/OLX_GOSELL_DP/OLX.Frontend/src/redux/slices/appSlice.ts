import { createSlice } from "@reduxjs/toolkit";
import { RootState } from "..";
import { IError } from "../../models/еrrors";


export interface IAppState {
    error: IError | null
    redirect: string | null
    scroll: boolean
}

const initialState: IAppState = {
    error: null,
    redirect: null,
    scroll: false
};

const appSlice = createSlice({
    name: 'app',
    initialState,
    reducers: {
        scrollTop: (state) => {
            state.scroll = true
        },
        resetScroll: (state) => {
            state.scroll = false
        },
        setError: (state, action: { payload: IError | null }) => {
            state.error = action.payload
        },
        clearError: (state) => {
            state.error = null
        },
        setRedirect: (state, action: { payload: string | null }) => {
            state.redirect = action.payload
        },
        clearRedirect: (state) => {
            state.redirect = null
        },
    },
})

export const getScroll = (state: RootState) => state.app.scroll;
export const getError = (state: RootState) => state.app.error;
export const getRedirect = (state: RootState) => state.app.redirect;
export const { setError, scrollTop, resetScroll, clearError, setRedirect, clearRedirect } = appSlice.actions
export default appSlice.reducer