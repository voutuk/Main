import { useDispatch, useSelector } from "react-redux";
import { clearError, getError } from "../../../redux/slices/appSlice";
import { useEffect } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { getAuth } from "../../../redux/slices/userSlice";



const ErrorHendler: React.FC = () => {
    const error = useSelector(getError);
    const navigator = useNavigate()
    const { location, isAdmin } = useSelector(getAuth)
    const currentlocation = useLocation();
    const dispatcher = useDispatch();
    useEffect(() => {
        if (error) {
            dispatcher(clearError())
            navigator(`${location}${isAdmin ? '/' : ''}error`, {
                replace: true,
                state: {
                    title: isNaN(error.status) ? 'Упс...щось пішло не так ...' : error.status.toString(),
                    subTitle: error.message || "Нажаль сталася помилка ... :(",
                    status: isNaN(error.status) ? 500 : error.status,
                    location: currentlocation.pathname
                }
            })
        }
    }, [error])
    return null
};
export default ErrorHendler;