import { useDispatch, useSelector } from "react-redux";
import { clearError, getRedirect } from "../../../redux/slices/appSlice";
import { useEffect, useRef } from "react";
import { useNavigate } from "react-router-dom";
import { getAuth } from "../../../redux/slices/userSlice";


const RedirectHendler: React.FC = () => {
    const redirect = useSelector(getRedirect);
    const { isAuth, location } = useSelector(getAuth)
    const navigate = useNavigate()
    const dispatcher = useDispatch();

    const isInit = useRef<boolean>(true)
    useEffect(() => {
        !isInit.current ? navigate(location) : isInit.current = false;
    }, [isAuth])

    useEffect(() => {
        if (redirect) {
            navigate(redirect)
            dispatcher(clearError())
        }
    }, [redirect])
    return null
};
export default RedirectHendler;