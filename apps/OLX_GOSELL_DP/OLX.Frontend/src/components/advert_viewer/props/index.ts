import { IAdvert } from "../../../models/advert";

export interface IAdvertViewerProps {
    buttons?:boolean,
    advert: IAdvert | undefined | null
}