import { createBaseQueryWithAuth } from "./baseQuery"
import { IAdminMesssage, IAdminMesssageCreationModel } from "../../models/adminMesssage"
import { createApi } from "@reduxjs/toolkit/query/react"
import { setMessages } from "../slices/userSlice"

export const adminMessageAuthApi = createApi({
    reducerPath: 'adminMessageAuthApi',
    baseQuery: createBaseQueryWithAuth('AdminMessage'),
    tagTypes: ['Messeges'],
    endpoints: (builder) => ({

        createAdminMessage: builder.mutation<IAdminMesssage, IAdminMesssageCreationModel>({
            query: (messageCreationModel) => {
                return {
                    url: 'create/admin',
                    method: 'PUT',
                    body: messageCreationModel
                    // timeout: 10000,
                }
            },
            invalidatesTags:['Messeges']
        }),

        createUserMessage: builder.mutation<IAdminMesssage, IAdminMesssageCreationModel>({
            query: (messageCreationModel) => {
                return {
                    url: 'create/user',
                    method: 'PUT',
                    body: messageCreationModel
                    // timeout: 10000,
                }
            },
            invalidatesTags:['Messeges']
        }),

        getAdminMessages: builder.query<IAdminMesssage[], void>({
            query: () => {
                return {
                    url: 'get/admin',
                    method: 'GET',
                    // timeout: 10000,
                }
            },
            providesTags: ["Messeges"],
            async onQueryStarted(_arg, { dispatch, queryFulfilled }) {
                try {
                    const result = await queryFulfilled;
                    if (result.data && result.data.length > 0) {
                        dispatch(setMessages(result.data))
                    }
                } catch (error) {
                    console.error('Load admin messages failed:', error);
                }
            },
        }),

        getUserMessages: builder.query<IAdminMesssage[], void>({
            query: () => {
                return {
                    url: 'get/user',
                    method: 'GET',
                    // timeout: 10000,
                }
            },
            providesTags: ["Messeges"],
             async onQueryStarted(_arg, { dispatch, queryFulfilled }) {
                try {
                    const result = await queryFulfilled;
                    if (result.data && result.data.length > 0) {
                        dispatch(setMessages(result.data))
                    }
                } catch (error) {
                    console.error('Load user messages failed:', error);
                }
            },
        }),
    }),
})
export const {
    useCreateAdminMessageMutation,
    useCreateUserMessageMutation,
    useGetAdminMessagesQuery,
    useGetUserMessagesQuery } = adminMessageAuthApi