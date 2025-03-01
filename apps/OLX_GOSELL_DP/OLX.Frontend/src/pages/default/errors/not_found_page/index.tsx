import ErrorPage from "../error_page";

const NotFoundPage:React.FC = () => {
    
    return (
        <ErrorPage
        status="404"
        title="404"
        subTitle="Вибачте, сторінка на яку ви намагаєтесь перейти не існує."
       />
    );
};

export default NotFoundPage;