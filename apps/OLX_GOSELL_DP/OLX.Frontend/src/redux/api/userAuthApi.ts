
import { createBaseQueryWithAuth } from "./baseQuery";
import { IOlxUser, IOlxUserPageRequest, PageResponse } from "../../models/user";
import { createApi } from "@reduxjs/toolkit/query/react";
import { getFormData } from "../../utilities/common_funct";

export const userAuthApi = createApi({
    reducerPath: 'userAuthApi',
    baseQuery: createBaseQueryWithAuth('User'),
    tagTypes: ['Users', 'Admins', 'LockedUsers','User'],
    endpoints: (builder) => ({

        getUsers: builder.query<IOlxUser[], void>({
            query: () => {
                return {
                    url: 'get',
                    method: 'GET',
                }
            },
            providesTags: ["Users"]
        }),

        getLockedUsers: builder.query<IOlxUser[], void>({
            query: () => {
                return {
                    url: 'get/locked',
                    method: 'GET',
                }
            },
            providesTags: ["LockedUsers"]
        }),

        getAdmins: builder.query<IOlxUser[], void>({
            query: () => {
                return {
                    url: 'get/admin',
                    method: 'GET',
                }
            },
            providesTags: ["Admins"]
        }),

        getUser: builder.query<IOlxUser, number>({
            query: (id: number) => {
                return {
                    url: `get/${id}`,
                    method: 'GET',
                }
            },
            providesTags: ["User"]
        }),

        getAdmin: builder.query<IOlxUser, number>({
            query: (id) => {
                return {
                    url: `get/admin/${id}`,
                    method: 'GET',
                }
            },
            providesTags: ["Admins"]
        }),

        getUserPage: builder.query<PageResponse<IOlxUser>, IOlxUserPageRequest>({
            query: (pageRequest) => {
                return {
                    url: `get/page`,
                    method: 'POST',
                    body: getFormData(pageRequest)
                }
            },
            providesTags: (result, _error, pageRequest) => {
                if (!result) {
                    if (pageRequest.isAdmin) {
                        return ["Admins"];
                    }
                    if (pageRequest.isLocked) {
                        return ["LockedUsers"];
                    }
                    return ["Users"]
                }
                else {
                    if (pageRequest.isAdmin) {
                        return [
                            "Admins",
                            { type: "Admins", id: pageRequest.page },
                        ];;
                    }
                    if (pageRequest.isLocked) {
                        return [
                            "LockedUsers",
                            { type: "LockedUsers", id: pageRequest.page },
                        ];
                    }
                    return [
                        "Users",
                        { type: "Users", id: pageRequest.page },
                    ];
                }

            },
        })
    }),
})
export const {
    useGetUserQuery,
    useGetAdminQuery,
    useGetAdminsQuery,
    useGetLockedUsersQuery,
    useGetUserPageQuery,
    useGetUsersQuery } = userAuthApi