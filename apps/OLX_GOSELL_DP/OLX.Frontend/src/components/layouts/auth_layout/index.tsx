import React, { Suspense } from 'react'

import { Outlet, useLocation, } from 'react-router-dom';
import { Images } from '../../../constants/images';
import GlobalFallback from '../../global_fallback';

const AuthLayout: React.FC = () => {
    const location = useLocation()
    return (
        <div className="flex h-screen w-screen  justify-between">
            <div className="w-[50%] h-[100%]">
                <img className="w-[100%] h-[100%] object-cover" src={location.pathname.includes('register') ? Images.registerPage : Images.loginImage} />
            </div>
            <div className="text-center flex w-[50%]">
                <Suspense fallback={<GlobalFallback />}>
                    <Outlet />
                </Suspense>
            </div>
        </div >
    )
}
export default AuthLayout;