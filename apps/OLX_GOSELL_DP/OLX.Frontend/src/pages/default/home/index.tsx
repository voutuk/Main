import AdvertsSection from '../../../components/adverts_section';
import HomePageImageBlock from '../../../components/home_page_image';
import PrimaryButton from '../../../components/buttons/primary_button';
import { useGetAdvertPageQuery } from '../../../redux/api/advertApi';
import './style.scss'
import { useEffect, useState } from 'react';
import { IAdvert } from '../../../models/advert';
import CategoriesSection from '../../../components/categories_section';


const HomePage: React.FC = () => {
  const [page, setPage] = useState(1);
  const [isEnd, setisEnd] = useState(false);
  const { data, isLoading } = useGetAdvertPageQuery({
    page,
    size: 8,
    sortKey: "date",
    isDescending: true,
    priceFrom: 0,
    priceTo: 0,
    approved: true,
    blocked: false,
    completed:false
  });

  const [adverts, setAdverts] = useState<IAdvert[]>([]);
  useEffect(() => {
    if (data && data?.items.length > 0) {
       const newAdverts =  [...adverts, ...data.items]
       setAdverts(newAdverts);
       setisEnd(data.total === newAdverts.length);
    }
  }, [data]);

  const loadMore = () => {
    setPage((prev) => prev + 1);
  };

  return (
    <div className="flex-1 flex flex-col justify-center">
      <HomePageImageBlock />
      <div className='flex flex-col items-center mx-[8vw] py-[10vh] gap-[10vh]'>
        <CategoriesSection />
        <AdvertsSection title='Рекомендовані оголошення' adverts={adverts} isLoading={isLoading} columns={4} />
        {!isEnd &&
          <PrimaryButton
            onButtonClick={loadMore}
            title='Завантажити більше'
            isLoading={isLoading}
            className='w-[23vw] h-[6.4vh] p-[8px]'
            bgColor='#9B7A5B'
            fontColor='white'
            brColor='#9B7A5B' />
        }
      </div>
    </div>
  );
};

export default HomePage;