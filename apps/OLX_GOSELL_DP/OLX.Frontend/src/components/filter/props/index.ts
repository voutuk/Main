import { IFilter } from "../../../models/filter"

export interface FilterProps {
    filter?: IFilter
    onChange?: () => void
    onReset?: (key: number | undefined) => void
}
