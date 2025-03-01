import { IUser } from "../../models/account";
import { IOlxUser, IShortOlxUser } from "../../models/user";

export interface IUserAvatarProps{
    user:IUser | IOlxUser | null | IShortOlxUser | undefined
    size?:number
    className?:string
    imageSize?:"100" | "200" | "400" | "800" | "1200"
}