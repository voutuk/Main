import { APP_ENV } from '../../constants/env';
import { IAdvert } from '../../models/advert';
import { useGetAdvertsByRangeQuery } from '../../redux/api/advertApi';
import ScrolledAdvertsSection from '../scrolled_adverts_section';

interface ViewedAdvertsProps {
    advert: IAdvert | undefined,
    className?: string
}

const ViewedAdverts: React.FC<ViewedAdvertsProps> = ({ advert, className }) => {
    const advertsIds: number[] = sessionStorage.getItem(APP_ENV.VIEWED_KEY) ? JSON.parse(sessionStorage.getItem(APP_ENV.VIEWED_KEY) as string) : null;
    const { data: adverts } = useGetAdvertsByRangeQuery(advertsIds)
    return (
        <>
            {adverts && adverts.length > 0 &&
                <ScrolledAdvertsSection
                    title='Нещодавно переглянуті'
                    adverts={adverts}
                    advertId={advert?.id}
                    className={className}
                    cardClassName="min-w-[20.5vw] max-w-[20.5vw]" />}
        </>
    )
}

export default ViewedAdverts