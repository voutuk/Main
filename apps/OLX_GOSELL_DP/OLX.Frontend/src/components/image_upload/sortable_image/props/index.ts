import { UploadFile } from "antd";

export interface SortableItemProps {
    onDelete: (uid: string | undefined) => void,
    onPreview: (preview: string) => void,
    file: UploadFile,
    uploadSize?: number,
}