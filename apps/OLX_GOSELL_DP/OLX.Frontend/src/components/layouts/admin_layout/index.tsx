import { AdminContent } from "./content"
import { AdminFooter } from "./footer"
import { AdminHeader } from "./header"
import { SideBar } from "./sidebar"

 const AdminLayout: React.FC = () => {
    return (
        <div className='flex flex-1  h-screen' >
            <SideBar />
            <div className='w-full h-full flex flex-col justify-stretch overflow-y-auto' >
                <AdminHeader />
                <AdminContent />
                <AdminFooter />
            </div>
        </div>
    )
}
export default AdminLayout