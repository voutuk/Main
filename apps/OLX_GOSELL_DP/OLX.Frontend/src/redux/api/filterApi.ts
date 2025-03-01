import { createApi } from "@reduxjs/toolkit/query/react";
import { createBaseQuery } from "./baseQuery";
import { PageResponse } from "../../models/user";
import { IFilter, IFilterPageRequest } from "../../models/filter";


export const filterApi = createApi({
    reducerPath: 'filterApi',
    baseQuery: createBaseQuery('Filter'),
    tagTypes: ['Filters','FilterPage'],

    endpoints: (builder) => ({
        getFilterPage: builder.query<PageResponse<IFilter>, IFilterPageRequest>({
            query: (pageRequest) => {
                return {
                    url: `get/page`,
                    method: 'POST',
                    body: pageRequest
                }
            },
            providesTags: ["FilterPage"]
        }),

        getAllFilter: builder.query<IFilter[], void>({
            query: () => {
                return {
                    url: `get`,
                    method: 'GET',
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