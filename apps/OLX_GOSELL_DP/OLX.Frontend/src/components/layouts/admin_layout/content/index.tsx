import { Suspense } from "react"
import { Outlet } from "react-router-dom"
import GlobalFallback from "../../../global_fallback"

export const AdminContent: React.FC = () => {
    return (
        <main className='flex-1 flex' >
            <Suspense fallback={<GlobalFallback />}>
                <Outlet />
            </Suspense>
        </main>
    )
}