import { ICategory } from "../../../../models/category"

export interface CategoryCreateProps {
    open: boolean,
    onClose: () => void
    category?: ICategory
}