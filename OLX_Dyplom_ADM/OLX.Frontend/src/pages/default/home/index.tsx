import HomePageImageBlock from '../../../components/home_page_image';
import './style.scss'
const HomePage:React.FC = () => {
  
    return (
      <div className="  flex-1 flex flex-col justify-center">
          <HomePageImageBlock/>
          <div className="my-96"> main page</div>
      </div>
    );
  };
  
  export default HomePage;