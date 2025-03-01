import { IAdvert } from "../../../models/advert";

export interface IAdvertInfoProps {
    buttons?:boolean,
    advert: IAdvert | undefined | null
}