import { Header } from "./header";
import { Content } from "./content";
import { Footer } from "./footer";

const DefaultLayout: React.FC = () => {

  return (
    <div className='w-full h-screen flex flex-col justify-stretch overflow-y-auto' >
      <Header />
      <Content />
      <Footer />
    </div>
  );
};

export default DefaultLayout;