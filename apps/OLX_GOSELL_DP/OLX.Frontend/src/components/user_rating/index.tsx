import { Rating } from "@mui/material"
import UserAvatar from "../user_avatar"
import { RightOutlined } from '@ant-design/icons';
import { getUserDescr } from "../../utilities/common_funct";
import { IUserRatingProps } from "./props";


const UserRating: React.FC<IUserRatingProps> = ({ user }) => {
    return(
        <div className="flex justify-between items-center">
            <div className="flex gap-[.5vw]">
                <UserAvatar user={user} className="w-[11vh] h-[11vh]" />
                <div className="flex flex-col self-center">
                    <span className="font-montserrat text-adaptive-advert-page-price-text">{getUserDescr(user)}</span>
                    <div className="flex gap-2 items-center">
                        <Rating readOnly sx={{ fontSize: "2.2vh" }} className="" value={5} />
                        <span className="font-montserrat text-adaptive-input-form-error-text">55</span>
                    </div>
                </div>
            </div>
            <RightOutlined className='text-black text-adaptive-input-form-error-text' />
        </div>
    )
}

export default UserRating