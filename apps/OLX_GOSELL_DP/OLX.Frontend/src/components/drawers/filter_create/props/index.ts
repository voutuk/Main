import { IFilter } from "../../../../models/filter"

export interface FilterCreateProps {
    open: boolean,
    onClose: () => void
    filter?: IFilter
}