import { createApi } from '@reduxjs/toolkit/query/react';
import { createBaseQueryWithAuth } from "./baseQuery"
import { IUserLockModel } from '../../models/account';
import { userAuthApi } from './userAuthApi';

export const accountApiAuth = createApi({
    reducerPath: 'accountApiAuth',
    baseQuery: createBaseQueryWithAuth('Account'),
    tagTypes: ['Account'],

    endpoints: (builder) => ({
        lockUnlockUsers: builder.mutation<void, IUserLockModel>({
            query: (usrLockModel) => {
                return {
                    url: 'block',
                    method: 'POST',
                    body: usrLockModel
                }
            },
            async onQueryStarted(_arg, { dispatch, queryFulfilled }) {
                try {
                    await queryFulfilled;
                    dispatch(userAuthApi.util.invalidateTags(['Users']))
                } catch (error) {
                    console.error('Lock/Unlock user failed:', error);
                }
            },
        }),
    }),
})

export const { useLockUnlockUsersMutation } = accountApiAuth