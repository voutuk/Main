import { createApi } from '@reduxjs/toolkit/query/react';
import { createBaseQuery } from "./baseQuery"
import { IAuthResponse, IEmailConfirmationModel, IGoogleLoginRequest, ILoginLocalRequest, ILoginRequest, IResetPasswordModel } from "../../models/account"
import { logOut, setCredentials } from '../slices/userSlice';


export const accountApi = createApi({
    reducerPath: 'accountApi',
    baseQuery: createBaseQuery('Account'),
    tagTypes: ['Account'],

    endpoints: (builder) => ({

        login: builder.mutation<IAuthResponse, ILoginLocalRequest>({
            query: (data) => {
                return {
                    url: 'login',
                    method: 'POST',
                    body: data as ILoginRequest,
                    timeout: 10000
                }
            },
            async onQueryStarted(arg, { dispatch, queryFulfilled }) {
                try {
                    const result = await queryFulfilled;
                    if (result.data && result.data.accessToken) {
                        dispatch(setCredentials({ token: result.data.accessToken, refreshToken: result.data.refreshToken, remember: arg.remember }))
                    }
                } catch (error) {
                    console.error('Login failed:', error);
                }
            },
        }),

        logout: builder.mutation<void, string>({
            query: (token) => {
                return {
                    url: 'user/logout',
                    method: 'POST',
                    credentials: "include",
                    body: { refreshToken: token },
                    timeout: 10000
                }
            },
            async onQueryStarted(_arg, { dispatch, queryFulfilled }) {
                try {
                    await queryFulfilled;
                    dispatch(logOut());
                } catch (error) {
                    console.error('Logout failed:', error);
                }
            },
        }),

        googleLogin: builder.mutation<IAuthResponse, IGoogleLoginRequest>({
            query: (data) => {
                return {
                    url: `login/google?googleAccessToken=${data.token}`,
                    method: 'POST',
                }
            },
            async onQueryStarted(arg, { dispatch, queryFulfilled }) {
                try {
                    const result = await queryFulfilled;
                    if (result.data && result.data.accessToken) {
                        dispatch(setCredentials({ token: result.data.accessToken, refreshToken: result.data.refreshToken, remember: arg.remember }))
                    }
                } catch (error) {
                    console.error('Google login failed:', error);
                }
            },
        }),

        sendConfirmEmail: builder.mutation<void, string>({
            query: (email) => {
                return {
                    url: `email/sendconfirm?email=${email}`,
                    method: 'POST'
                }
            },
        }),

        sendPasswordResetEmail: builder.mutation<void, string>({
            query: (email) => {
                return {
                    url: `password/fogot?email=${email}`,
                    method: 'POST'
                }
            },
        }),

        confirmEmail: builder.mutation<void, IEmailConfirmationModel>({
            query: (confirmationModel) => {
                return {
                    url: 'email/confirm',
                    method: 'POST',
                    body: confirmationModel
                }
            },
        }),

        resetPassword: builder.mutation<void, IResetPasswordModel>({
            query: (passwordResetModel) => {
                return {
                    url: 'password/reset',
                    method: 'POST',
                    body: passwordResetModel
                }
            },
        }),

        // register: builder.mutation<ILoginResponse, IUserCreate>({
        //     query: (data) => {
        //         const formData = generateUserCreateFormData(data)
        //         return {
        //             url: 'SignUp',
        //             method: 'POST',
        //             body: formData,
        //             headers: {
        //                 'Content-Type': 'multipart/form-data'
        //             }
        //         }
        //     },
        // }),
    }),


})

export const {
    useLoginMutation,
    useSendConfirmEmailMutation,
    useConfirmEmailMutation,
    useSendPasswordResetEmailMutation,
    useResetPasswordMutation,
    useGoogleLoginMutation,
    useLogoutMutation } = accountApi