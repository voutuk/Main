
import { formattedDate, getFormatDateTime } from "../../utilities/common_funct";
import { IUserInfoProps } from "./props";

const UserInfo: React.FC<IUserInfoProps> = ({ user }) => {
    return (
        <div className="flex gap-[1vh] flex-col">
            <span className="font-montserrat text-adaptive-input-form-text">На GoSell з {formattedDate(new Date(user?.createdDate || '')).slice(2)}</span>
            <span className="font-montserrat text-adaptive-input-form-text">Онлайн {getFormatDateTime(new Date(user?.lastActivity || ''))}</span>
            {user?.settlementDescrption &&
                <div className="flex gap-[.2vw]">
                    <svg xmlns="http://www.w3.org/2000/svg" className="h-[2.6vh] p-0 m-0" viewBox="0 0 24 24" fill="none">
                        <path d="M12 2C8.13 2 5 5.13 5 9C5 14.25 12 22 12 22C12 22 19 14.25 19 9C19 5.13 15.87 2 12 2ZM7 9C7 6.24 9.24 4 12 4C14.76 4 17 6.24 17 9C17 11.88 14.12 16.19 12 18.88C9.92 16.21 7 11.85 7 9Z" fill="#000000" />
                        <path d="M12 11.5C13.3807 11.5 14.5 10.3807 14.5 9C14.5 7.61929 13.3807 6.5 12 6.5C10.6193 6.5 9.5 7.61929 9.5 9C9.5 10.3807 10.6193 11.5 12 11.5Z" fill="#000000" />
                    </svg>
                    <span className="font-montserrat text-adaptive-input-form-text">{user?.settlementDescrption}</span>
                </div>
            }
        </div>
    )
}

export default UserInfo