import { createSlice } from "@reduxjs/toolkit";
import { RootState } from "..";
import { IError } from "../../models/Errors";


export interface IAppState {
    error: IError | null
    redirect: string | null
}

const initialState: IAppState = {
    error: null,
    redirect: null
};
const appSlice = createSlice({
    name: 'app',
    initialState,
    reducers: {
        setError: (state, action: { payload:  IError | null  }) => {
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
export const getError = (state: RootState) => state.app.error;
export const getRedirect = (state: RootState) => state.app.redirect;
export const { setError, clearError,setRedirect, clearRedirect} = appSlice.actions
export default appSlice.reducer