import { createApi } from "@reduxjs/toolkit/query/react"
import { createBaseQueryWithAuth } from "./baseQuery"
import { ICategoryCreationModel } from "../../models/category";
import { categoryApi } from "./categoryApi";
import { getFormData } from "../../utilities/common_funct";

export const categoryAuthApi = createApi({
    reducerPath: 'categoryAuthApi',
    baseQuery: createBaseQueryWithAuth('Category'),
    endpoints: (builder) => ({
        createCategory: builder.mutation<void, ICategoryCreationModel>({
            query: (creationModel) => {
                return {
                    url: `create`,
                    method: 'PUT',
                    // timeout: 10000,
                    body: getFormData(creationModel)
                }
            },
            async onQueryStarted(_arg, { dispatch, queryFulfilled }) {
                try {
                    await queryFulfilled;
                    dispatch(categoryApi.util.invalidateTags(['Categories','CategoriesPage']))
                } catch (error) {
                    console.error('Create category failed:', error);
                }
            },
        }),

        editCategory: builder.mutation<void, ICategoryCreationModel>({
            query: (creationModel) => {
                return {
                    url: `edit`,
                    method: 'POST',
                    // timeout: 10000,
                    body: getFormData(creationModel)
                }
            },
            async onQueryStarted(_arg, { dispatch, queryFulfilled }) {
                try {
                    await queryFulfilled;
                    dispatch(categoryApi.util.invalidateTags(['Categories','CategoriesPage','Category']))
                } catch (error) {
                    console.error('Edit category failed:', error);
                }
            },
        }),
        deleteCategory: builder.mutation<void, number>({
            query: (categoryId) => {
                return {
                    url: `delete/${categoryId}`,
                    method: 'DELETE'
                    // timeout: 10000,
                }
            },
            async onQueryStarted(_arg, { dispatch, queryFulfilled }) {
                try {
                    await queryFulfilled;
                    dispatch(categoryApi.util.invalidateTags(['Categories','CategoriesPage','Category']))
                } catch (error) {
                    console.error('Delete category failed:', error);
                }
            },
        }),
        deleteCategoryTree: builder.mutation<void, number>({
            query: (categoryId) => {
                return {
                    url: `delete/tree/${categoryId}`,
                    method: 'DELETE'
                    // timeout: 10000,
                }
            },
            async onQueryStarted(_arg, { dispatch, queryFulfilled }) {
                try {
                    await queryFulfilled;
                    dispatch(categoryApi.util.invalidateTags(['Categories','CategoriesPage','Category']))
                } catch (error) {
                    console.error('Delete category failed:', error);
                }
            },
        }),
    }),
})

export const {
    useCreateCategoryMutation,
    useEditCategoryMutation,
    useDeleteCategoryMutation,
    useDeleteCategoryTreeMutation
} = categoryAuthApi