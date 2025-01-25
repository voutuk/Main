
import { Avatar } from "antd";
import { IUserAvatarProps } from "./props";
import { getUserDescr, stringToColor } from "../../utilities/common_funct";
import { APP_ENV } from "../../constants/env";



const UserAvatar: React.FC<IUserAvatarProps> = ({ user, size }) => {

    if (user) {
        if (user.photo) {
            return <Avatar className=" flex-shrink-0" size={size} src={APP_ENV.IMAGES_100_URL + user.photo} />
        }
        const userDesc = getUserDescr(user);
        const userStrings = userDesc.split(' ');
        let avatarDesc = ''
        if(userStrings?.length == 1){
            avatarDesc = userStrings[0][0];
        }
        else{
            avatarDesc = userStrings[0][0] + userStrings[1][0];
        }
        const color = stringToColor(userDesc);
        return <Avatar style={{ backgroundColor: color, verticalAlign: 'middle', flexShrink: 0 }} size={size}>
            {avatarDesc.toUpperCase()}
        </Avatar>
    }
    return null;
};

export default UserAvatar;