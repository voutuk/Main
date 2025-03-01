import { IFilter } from "../../../../../models/filter";

export interface FilterDrawerDataModel {
    isDrawerOpen: boolean,
    selectedFilter: IFilter | undefined
}