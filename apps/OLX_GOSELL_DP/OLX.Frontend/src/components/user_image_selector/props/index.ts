import { UploadFile } from "antd"

export interface UserImageSelectorProps {
    value?: UploadFile
    onChange?: (value: any) => void
    className?: string
}