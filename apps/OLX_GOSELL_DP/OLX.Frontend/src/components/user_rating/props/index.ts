import { IUser } from "../../../models/account";
import { IOlxUser, IShortOlxUser } from "../../../models/user";

export interface IUserRatingProps {
    user: IOlxUser | IUser | IShortOlxUser | undefined | null
}