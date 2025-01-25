
import { APP_ENV } from '../../constants/env';
import { RootState } from '..';
import { BaseQueryApi, FetchArgs, fetchBaseQuery } from '@reduxjs/toolkit/query';
import { IAuthResponse } from '../../models/account';
import { setCredentials } from '../slices/userSlice';





export const createBaseQuery = (endpoint: string) =>
    fetchBaseQuery({
        baseUrl: `${APP_ENV.API_URL}/${endpoint}/`
    })

export const createBaseQueryWithAuth = (endpoint: string) => {

    return async (args: string | FetchArgs, api: BaseQueryApi, extraOptions: any) => {

        const state = api.getState() as RootState;
        const user = state.user.user;
        if (user) {
            let token = state.user.token;
            if (new Date(user.exp * 1000) < new Date()) {
                const response = await createBaseQuery(endpoint)(
                    {
                        url: `${APP_ENV.API_URL}/Account/user/refresh`,
                        method: 'POST',
                        credentials: 'include',
                        body: { refreshToken: state.user.refreshToken }
                    },
                    api,
                    extraOptions
                );
                if (response.data && (response.data as IAuthResponse).accessToken) {
                    token = (response.data as IAuthResponse).accessToken;
                    const refreshToken = (response.data as IAuthResponse).refreshToken;
                    const remember = state.user.auth.remember
                    api.dispatch(setCredentials({ token: token, refreshToken: refreshToken, remember: remember }))
                    console.log('Tokens refreshed')
                }
                else if (response.error) {
                    return response
                }
            }
            const baseQuery = fetchBaseQuery({
                baseUrl: `${APP_ENV.API_URL}/${endpoint}/`,
                prepareHeaders: (headers) => {
                    headers.set('Authorization', `Bearer ${token}`);
                    return headers;
                },
            })
            return await baseQuery(args, api, extraOptions);
        }
        return {
            status: 401,
            data: {
                message: 'Unauthorized',
                error: 'Invalid credentials'
            }
        }
    }
}