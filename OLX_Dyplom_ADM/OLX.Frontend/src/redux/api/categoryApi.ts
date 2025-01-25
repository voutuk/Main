import { createApi } from "@reduxjs/toolkit/query/react"
import { createBaseQuery } from "./baseQuery"
import { ICategory, ICategoryPageRequest } from "../../models/category"
import { PageResponse } from "../../models/user"

export const categoryApi = createApi({
    reducerPath: 'categoryApi',
    baseQuery: createBaseQuery('Category'),
    tagTypes: ['Categories'],

    endpoints: (builder) => ({
        getCategoryPage: builder.query<PageResponse<ICategory>, ICategoryPageRequest>({
            query: (pageRequest) => {
                return {
                    url: `get/page`,
                    method: 'POST',
                    // timeout: 10000,
                    body: pageRequest
                }
            },
            providesTags: ["Categories"]
        }),

        getAllCategories: builder.query<ICategory[], void>({
            query: () => {
                return {
                    url: `get`,
                    method: 'GET',
                }
            },
            providesTags: ["Categories"]
        }),

        getAllCategoriesTree: builder.query<ICategory[], void>({
            query: () => {
                return {
                    url: `get/tree`,
                    method: 'GET',
                }
            },
            providesTags: ["Categories"]
        }),

    }),
})

export const {
   useGetCategoryPageQuery,
   useGetAllCategoriesQuery,
   useGetAllCategoriesTreeQuery
} = categoryApi