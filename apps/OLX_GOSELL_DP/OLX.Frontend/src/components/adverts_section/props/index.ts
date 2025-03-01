import { IAdvert } from "../../../models/advert";

export interface AdvertsSectionProps {
    title?: string,
    adverts?: IAdvert[]
    isLoading: boolean
    className?: string
    columns?:number
}