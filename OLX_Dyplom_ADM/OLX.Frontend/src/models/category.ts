import { PageRequest } from "./user"

export interface ICategory {
    id: number,
    name: string,
    image?: string,
    parentId?: number,
    parentName?: string,
    filters: number[],
    filterNames: string[],
    childs: ICategory[],
}

export interface ICategoryPageRequest extends PageRequest {
    searchName?: string
    parentName: string
}

export interface ICategoryCreationModel {
    id: number,
    name: string,
    imageFile?: File
    parentId?: number
    filterIds?: number[]
    currentImage?: string
}