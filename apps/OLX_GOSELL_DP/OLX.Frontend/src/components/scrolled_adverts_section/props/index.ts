import { IAdvert } from "../../../models/advert";

export interface IScrolledAdvertsSectionProps {
    title: string,
    adverts: IAdvert[],
    advertId: number | undefined,
    className?: string,
    cardClassName?:string
}