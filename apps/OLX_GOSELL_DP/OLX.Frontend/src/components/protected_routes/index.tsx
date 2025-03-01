import { useSelector } from "react-redux";
import { getAuth } from "../../redux/slices/userSlice";
import { Navigate, Outlet } from "react-router-dom";

type ProtectedRouteType = "User" | "Admin" | "UnAuth"

const ProtectedRoutes = ({ requiredRole }: { requiredRole?: ProtectedRouteType | ProtectedRouteType[] }) => {
    const { roles, isAuth, location } = useSelector(getAuth);
    const userRoles = Array.isArray(roles) ? roles : [roles];
    const requiredRoles = Array.isArray(requiredRole) ? requiredRole : [requiredRole];
    if ((!isAuth && requiredRoles.includes("UnAuth")) ||
        (isAuth && requiredRoles.some(role => userRoles.includes(role || '')))) {
        return <Outlet />;
    }
    return <Navigate to={!isAuth ? "/auth" : location} replace />;
};

export default ProtectedRoutes;