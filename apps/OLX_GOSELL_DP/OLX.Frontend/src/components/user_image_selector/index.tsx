import { Image, Upload } from "antd"
import { useEffect, useState } from "react";
import { FileType } from "../../utilities/common_funct";
import PrimaryButton from "../buttons/primary_button";
import imageCompression from "browser-image-compression";
import { Images } from "../../constants/images";
import {UserImageSelectorProps} from './props'


const UserImageSelector: React.FC<UserImageSelectorProps> = ({ value, onChange, className }) => {
    const [previewOpen, setPreviewOpen] = useState(false);
    const [previewImage, setPreviewImage] = useState("");
    const [thumbUrl, setThumbUrl] = useState<string | undefined>(undefined)
    
    const handlePreview = async () => {
        if (value) {
            setPreviewImage(value.url || URL.createObjectURL(value.originFileObj as FileType));
            setPreviewOpen(true);
        }
    };
    const onDelete = () => {
        onChange && onChange(undefined)
    }

    const onImageLoad = (data: any) => {
        onChange && onChange(data.fileList[1] || data.fileList[0])
    }

    useEffect(() => {
        (async () => {
            if (value && !value.thumbUrl) {
                const smallFile = await imageCompression(value.originFileObj as FileType, { maxWidthOrHeight: 200 })
                setThumbUrl(URL.createObjectURL(smallFile))
            }
            else {
                setThumbUrl(Images.noImage)
            }
        })()
    }, [value])

    return (
        <>
            <div className="flex gap-[1.4vw]">
                <div className={`relative aspect-[16/16] ${className}`} >
                    <img className="h-full rounded-[50%] object-cover w-full" src={value?.thumbUrl || thumbUrl} />
                    <div className="transition-opacity duration-500 w-full  rounded-[50%] h-full absolute bg-black top-0 opacity-0  hover:opacity-50" >
                        <div className=" flex gap-[15%] justify-center my-[42.5%] w-full h-[15%] absolute  top-0 " >
                            <svg onMouseDown={handlePreview} className="h-full w-auto" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <path d="M23.432 10.5241C20.787 7.61407 16.4 4.53807 12 4.60007C7.60002 4.53707 3.21302 7.61507 0.568023 10.5241C0.205452 10.9294 0.00500488 11.4542 0.00500488 11.9981C0.00500488 12.5419 0.205452 13.0667 0.568023 13.4721C3.18202 16.3511 7.50702 19.4001 11.839 19.4001H12.147C16.494 19.4001 20.818 16.3511 23.435 13.4711C23.7971 13.0655 23.997 12.5407 23.9964 11.997C23.9959 11.4533 23.7949 10.9289 23.432 10.5241ZM7.40002 12.0001C7.40002 11.0903 7.66981 10.2009 8.17526 9.44445C8.68072 8.68798 9.39914 8.09839 10.2397 7.75023C11.0802 7.40206 12.0051 7.31097 12.8974 7.48846C13.7898 7.66595 14.6094 8.10406 15.2527 8.74738C15.896 9.3907 16.3341 10.2103 16.5116 11.1027C16.6891 11.995 16.598 12.9199 16.2499 13.7604C15.9017 14.601 15.3121 15.3194 14.5556 15.8248C13.7992 16.3303 12.9098 16.6001 12 16.6001C10.78 16.6001 9.61 16.1154 8.74733 15.2528C7.88466 14.3901 7.40002 13.2201 7.40002 12.0001Z" fill="white" />
                                <path d="M12 14.0001C13.1046 14.0001 14 13.1046 14 12.0001C14 10.8955 13.1046 10.0001 12 10.0001C10.8955 10.0001 10 10.8955 10 12.0001C10 13.1046 10.8955 14.0001 12 14.0001Z" fill="black" />
                            </svg>
                            <svg onMouseDown={() => onDelete && onDelete()} className="h-full w-auto" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <path d="M19.452 7.5H4.547C4.47737 7.49972 4.40846 7.51398 4.34466 7.54187C4.28087 7.56977 4.2236 7.61068 4.17653 7.66198C4.12946 7.71329 4.09363 7.77386 4.07132 7.83981C4.04902 7.90577 4.04073 7.97566 4.047 8.045L5.334 22.181C5.37917 22.6781 5.60858 23.1403 5.97717 23.4769C6.34575 23.8135 6.82687 24.0001 7.326 24H16.673C17.1721 24.0001 17.6532 23.8135 18.0218 23.4769C18.3904 23.1403 18.6198 22.6781 18.665 22.181L19.95 8.045C19.9562 7.97586 19.9479 7.90619 19.9257 7.84042C19.9035 7.77465 19.8678 7.71423 19.821 7.663C19.7742 7.61169 19.7172 7.5707 19.6537 7.54264C19.5901 7.51457 19.5215 7.50005 19.452 7.5ZM10.252 20.5C10.252 20.6989 10.173 20.8897 10.0323 21.0303C9.89168 21.171 9.70091 21.25 9.502 21.25C9.30309 21.25 9.11232 21.171 8.97167 21.0303C8.83102 20.8897 8.752 20.6989 8.752 20.5V11.5C8.752 11.3011 8.83102 11.1103 8.97167 10.9697C9.11232 10.829 9.30309 10.75 9.502 10.75C9.70091 10.75 9.89168 10.829 10.0323 10.9697C10.173 11.1103 10.252 11.3011 10.252 11.5V20.5ZM15.252 20.5C15.252 20.6989 15.173 20.8897 15.0323 21.0303C14.8917 21.171 14.7009 21.25 14.502 21.25C14.3031 21.25 14.1123 21.171 13.9717 21.0303C13.831 20.8897 13.752 20.6989 13.752 20.5V11.5C13.752 11.3011 13.831 11.1103 13.9717 10.9697C14.1123 10.829 14.3031 10.75 14.502 10.75C14.7009 10.75 14.8917 10.829 15.0323 10.9697C15.173 11.1103 15.252 11.3011 15.252 11.5V20.5ZM22 4H17.25C17.1837 4 17.1201 3.97366 17.0732 3.92678C17.0263 3.87989 17 3.8163 17 3.75V2.5C17 1.83696 16.7366 1.20107 16.2678 0.732233C15.7989 0.263392 15.163 0 14.5 0H9.5C8.83696 0 8.20107 0.263392 7.73223 0.732233C7.26339 1.20107 7 1.83696 7 2.5V3.75C7 3.8163 6.97366 3.87989 6.92678 3.92678C6.87989 3.97366 6.8163 4 6.75 4H2C1.73478 4 1.48043 4.10536 1.29289 4.29289C1.10536 4.48043 1 4.73478 1 5C1 5.26522 1.10536 5.51957 1.29289 5.70711C1.48043 5.89464 1.73478 6 2 6H22C22.2652 6 22.5196 5.89464 22.7071 5.70711C22.8946 5.51957 23 5.26522 23 5C23 4.73478 22.8946 4.48043 22.7071 4.29289C22.5196 4.10536 22.2652 4 22 4ZM9 3.75V2.5C9 2.36739 9.05268 2.24021 9.14645 2.14645C9.24021 2.05268 9.36739 2 9.5 2H14.5C14.6326 2 14.7598 2.05268 14.8536 2.14645C14.9473 2.24021 15 2.36739 15 2.5V3.75C15 3.8163 14.9737 3.87989 14.9268 3.92678C14.8799 3.97366 14.8163 4 14.75 4H9.25C9.1837 4 9.12011 3.97366 9.07322 3.92678C9.02634 3.87989 9 3.8163 9 3.75Z" fill="white" />
                            </svg>
                        </div>
                    </div>
                </div>
                <div className="flex flex-col justify-between gap-[1vh] py-[1vh]">
                    <div className="flex flex-col gap-[.6vh]">
                        <span className="font-unbounded text-adaptive-1_7_text font-medium">Змінити фото профілю</span>
                        <span className="font-montserrat text-adaptive-1_7_text">Виберіть квадратне фото не менше 200*200</span>
                    </div>
                    <Upload
                        onChange={onImageLoad}
                        fileList={value ? [value] : []}
                        accept=".jpg,.png,.webp,.jpeg"
                        beforeUpload={() => false}
                        showUploadList={false}
                    >
                        <PrimaryButton
                            title={"Завантажити фото"}
                            isLoading={false}
                            bgColor="white"
                            brColor="black"
                            className="h-[4.2vh] w-[11.3vw]"
                            fontSize="clamp(14px,1.9vh,30px)"
                        />
                    </Upload>
                </div>
            </div>

            {previewImage && (
                <Image
                    wrapperStyle={{ display: 'none' }}
                    preview={{
                        visible: previewOpen,
                        onVisibleChange: (visible) => setPreviewOpen(visible),
                        afterOpenChange: (visible) => !visible && setPreviewImage(''),
                    }}
                    src={previewImage}
                />
            )}
        </>)
}

export default UserImageSelector