export interface AdvertCardProps{
    id: number,
    image: string,
    title: string,
    price: number,
    settlement: string,
    isEditable?: boolean,
    isFavorite?: boolean,
    className?:string,
 }