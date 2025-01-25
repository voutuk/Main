import { createApi } from "@reduxjs/toolkit/query/react";
import { createBaseQuery } from "./baseQuery";
import { PageResponse } from "../../models/user";
import { IFilter, IFilterPageRequest } from "../../models/filter";


export const filterApi = createApi({
    reducerPath: 'filterApi',
    baseQuery: createBaseQuery('Filter'),
    tagTypes: ['Filters'],

    endpoints: (builder) => ({
        getFilterPage: builder.query<PageResponse<IFilter>, IFilterPageRequest>({
            query: (pageRequest) => {
                return {
                    url: `get/page`,
                    method: 'POST',
                    // timeout: 10000,
                    body: pageRequest
                }
            },
            providesTags: ["Filters"]
        }),

        getAllFilter: builder.query<IFilter[], void>({
            query: () => {
                return {
                    url: `get`,
                    method: 'GET',
                    // timeout: 10000,
                }
            },
            providesTags: ["Filters"]
        }),

    }),
})

export const {
    useGetFilterPageQuery,
    useGetAllFilterQuery
} = filterApi