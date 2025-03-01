import { createApi } from "@reduxjs/toolkit/query/react"
import { createBaseQuery } from "./baseQuery"
import { ICategory, ICategoryPageRequest } from "../../models/category"
import { PageResponse } from "../../models/user"

export const categoryApi = createApi({
    reducerPath: 'categoryApi',
    baseQuery: createBaseQuery('Category'),
    tagTypes: ['Categories','CategoriesPage','Category'],

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
            providesTags: ["CategoriesPage"]
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

        getCategoryById: builder.query<ICategory, number>({
            query: (categoryId) => {
                return {
                    url: `get/${categoryId}`,
                    method: 'GET',
                }
            },
            providesTags: ["Category"]
        }),

    }),
})

export const {
   useGetCategoryPageQuery,
   useGetAllCategoriesQuery,
   useGetAllCategoriesTreeQuery,
   useGetCategoryByIdQuery
} = categoryApi