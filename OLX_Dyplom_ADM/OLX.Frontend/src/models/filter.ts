import { PageRequest } from "./user"

export interface IFilter {
    id: number,
    name: string,
    values: IFilterValue[]
}

export interface IFilterValue {
    id: number,
    filterId: number,
    value: string
}

export interface IFilterCreationModel{
    name: string,
    values: string[]
} 

export interface IFilterEditModel{
    id: number,
    name: string,
    newValues:string[],
    oldValues:IEditFilterValues[]
}

export interface IEditFilterValues{
    id: number,
    value: string,
}

export interface IFilterPageRequest extends PageRequest {
    searchName?:string
} 