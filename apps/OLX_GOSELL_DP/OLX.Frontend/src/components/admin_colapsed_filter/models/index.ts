import { IFilter } from "../../../models/filter"

export interface AdminFilterResultModel {
    filters: number[][]
    categoryId: number
    priceFrom: number | null | undefined
    priceTo: number | null | undefined
}


export interface FilterData {
    filters: IFilter[]
    filtersValues: number[][]
    filterWidth: number
    isFilterClear: boolean
}
