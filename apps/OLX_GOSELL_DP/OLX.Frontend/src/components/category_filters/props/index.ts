
export interface CategoryFiltersProps {
    categoryFiltersIds?: number[]
    onChange?: (filters: number[][], priceFrom: number | undefined, priceTo: number | undefined, isContractPrice: boolean | undefined) => void
    className?: string
}
