import { useSelector } from "react-redux";
import { getAuth } from "../../redux/slices/userSlice";
import { Navigate, Outlet } from "react-router-dom";

type ProtectedRouteType = "User" | "Admin" | "UnAuth"

const ProtectedRoutes = ({ requiredRole }: { requiredRole?: ProtectedRouteType | ProtectedRouteType[] }) => {
    const { roles, isAuth, location } = useSelector(getAuth);
    const unAuthAlow = !isAuth && requiredRole?.includes("UnAuth");
    let routeAlow: boolean | undefined = unAuthAlow;
    if (requiredRole) {
        if (Array.isArray(requiredRole)) {
            routeAlow ||= !isAuth && requiredRole.includes("UnAuth");
            if (Array.isArray(roles)) {
                routeAlow ||= roles.some(role => requiredRole.includes(role as ProtectedRouteType))
            }
            else {
                routeAlow ||= requiredRole.includes(roles as ProtectedRouteType)
            }
        }
        else {
            if (Array.isArray(roles)) {
                routeAlow ||= roles.includes(requiredRole)
            }
            else {
                routeAlow ||= roles === requiredRole
            }
        }
    }
    else {
        routeAlow = isAuth
    }
    return routeAlow ? <Outlet /> : unAuthAlow ? <Navigate to="/auth" replace /> : <Navigate to={location} replace />
};

export default ProtectedRoutes;