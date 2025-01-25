import { IUser } from "../../models/account";
import { IOlxUser } from "../../models/user";

export interface IUserAvatarProps{
    user:IUser | IOlxUser |null
    size:number
}