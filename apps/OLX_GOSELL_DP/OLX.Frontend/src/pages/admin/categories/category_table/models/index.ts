import { ICategory } from "../../../../../models/category";

export interface DrawerDataModel {
    isDrawerOpen: boolean,
    selectedCategory: ICategory | undefined
}