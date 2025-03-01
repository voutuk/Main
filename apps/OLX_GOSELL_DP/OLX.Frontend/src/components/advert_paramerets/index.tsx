import { useGetAllFilterQuery } from "../../redux/api/filterApi"
import { useMemo } from "react"
import { AdvertParametersProps } from "./props"

const AdvertParameters: React.FC<AdvertParametersProps> = ({ advertValues, className }) => {
    const { data: filters, isLoading: isFilterLoading } = useGetAllFilterQuery()
    const parameters = useMemo(()=>advertValues && filters ? advertValues.map((x, index) =>
        <div key={index} className="flex gap-3">
            <span className="text-adaptive-footer-text font-montserrat text-black font-medium">{filters?.find(z => z.id == x.filterId)?.name || ''}:</span>
            <span className="text-adaptive-footer-text font-montserrat text-black ">{x.value}</span>
        </div>
    ):[],[advertValues , filters])

    return (
        <>
            {!isFilterLoading &&
                <div className={`flex gap-x-[2vw] gap-y-[1vh] flex-wrap  ${className}`}  >
                    {...parameters}
                </div>
            }
        </>
    )
}
export default AdvertParameters 