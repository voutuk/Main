import { createApi } from "@reduxjs/toolkit/query/react"
import { createBaseQueryWithAuth } from "./baseQuery"
import { IFilterCreationModel, IFilterEditModel } from "../../models/filter"
import { filterApi } from "./filterApi"

export const filterAuthApi = createApi({
    reducerPath: 'filterAuthApi',
    baseQuery: createBaseQueryWithAuth('Filter'),
    endpoints: (builder) => ({

        createFilter: builder.mutation<void, IFilterCreationModel>({
            query: (creationModel) => {
                return {
                    url: `create`,
                    method: 'PUT',
                    // timeout: 10000,
                    body: creationModel
                }
            },
            async onQueryStarted(_arg, { dispatch, queryFulfilled }) {
                try {
                    await queryFulfilled;
                    dispatch(filterApi.util.invalidateTags(['Filters','FilterPage']))
                } catch (error) {
                    console.error('Create filter failed:', error);
                }
            },
        }),

        updateFilter: builder.mutation<void, IFilterEditModel>({
            query: (editModel) => {
                return {
                    url: `edit`,
                    method: 'POST',
                    // timeout: 10000,
                    body: editModel
                }
            },
            async onQueryStarted(_arg, { dispatch, queryFulfilled }) {
                try {
                    await queryFulfilled;
                    dispatch(filterApi.util.invalidateTags(['Filters','FilterPage']))
                } catch (error) {
                    console.error('Update filter failed:', error);
                }
            },
        }),

        deleteFilter: builder.mutation<void, number>({
            query: (filterId) => {
                return {
                    url: `delete/${filterId}`,
                    method: 'DELETE',
                    // timeout: 10000,

                }
            },
            async onQueryStarted(_arg, { dispatch, queryFulfilled }) {
                try {
                    await queryFulfilled;
                    dispatch(filterApi.util.invalidateTags(['Filters','FilterPage']))
                } catch (error) {
                    console.error('Delete filter failed:', error);
                }
            },
        }),
    }),
})

export const {
    useCreateFilterMutation,
    useDeleteFilterMutation,
    useUpdateFilterMutation
} = filterAuthApi