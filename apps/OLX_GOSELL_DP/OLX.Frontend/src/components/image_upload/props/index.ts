import { UploadFile } from "antd"


export interface UploadWithDndProps {
    images?: UploadFile[]
    onChange?: (files: UploadFile[]) => void
    uploadSize?: number
    className?: string
    maxCount?: number
    defaultCount?: number
    columns?: number
    rowHeight?: number
}