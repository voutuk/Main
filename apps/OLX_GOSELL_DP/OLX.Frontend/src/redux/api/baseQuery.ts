
import { APP_ENV } from '../../constants/env';
import { RootState } from '..';
import { BaseQueryApi, FetchArgs, fetchBaseQuery } from '@reduxjs/toolkit/query';
import { IAuthResponse } from '../../models/account';
import { logOut, setCredentials } from '../slices/userSlice';

export const createBaseQuery = (endpoint: string) =>
    fetchBaseQuery({
        baseUrl: `${APP_ENV.API_URL}/${endpoint}/`
    })

let refreshMutex: Promise<string | null> | null = null;

const refreshTokens = async (api: BaseQueryApi, extraOptions: any, endpoint: string): Promise<string | null> => {
    if (!refreshMutex) {
        refreshMutex = (async () => {
            try {
                const state = api.getState() as RootState;
                const response = await createBaseQuery(endpoint)(
                    {
                        url: `${APP_ENV.API_URL}/Account/user/refresh`,
                        method: 'POST',
                        body: { refreshToken: state.user.refreshToken }
                    },
                    api,
                    extraOptions
                );

                if (!response.error && response.data && (response.data as IAuthResponse).accessToken) {
                    const newToken = (response.data as IAuthResponse).accessToken;
                    const refreshToken = (response.data as IAuthResponse).refreshToken;
                    const remember = state.user.auth.remember;
                    api.dispatch(setCredentials({ token: newToken, refreshToken, remember }));
                    return newToken;
                } else {
                    api.dispatch(logOut())
                    return null;
                }
            } finally {
                refreshMutex = null; // Звільняємо блокування після завершення
            }
        })();
    }

    return await refreshMutex;
};

export const createBaseQueryWithAuth = (endpoint: string) => {
    return async (args: string | FetchArgs, api: BaseQueryApi, extraOptions: any) => {
        let state = api.getState() as RootState;
        let token = state.user.token;

        if (state.user.user) {
            if (new Date(state.user.user.exp * 1000) < new Date()) {
                const newToken = await refreshTokens(api, extraOptions, endpoint);
                if (newToken) {
                    token = newToken;
                } else {
                    return {
                        status: 401,
                        data: {
                            message: 'Unauthorized',
                            error: 'Invalid credentials'
                        }
                    };
                }
            }

            const baseQuery = fetchBaseQuery({
                baseUrl: `${APP_ENV.API_URL}/${endpoint}/`,
                prepareHeaders: (headers) => {
                    headers.set('Authorization', `Bearer ${token}`);
                    return headers;
                },
            });

            return await baseQuery(args, api, extraOptions);
        }
        return {
            status: 401,
            data: {
                message: 'Unauthorized',
                error: 'Invalid credentials'
            }
        };
    };
};