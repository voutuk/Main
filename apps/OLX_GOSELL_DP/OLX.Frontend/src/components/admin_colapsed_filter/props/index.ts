import { AdminFilterResultModel } from "../models"

export interface AdminAdvertFiltersProps {
    onFiltersChange: (values: AdminFilterResultModel) => void
    columns?: number
}