import { PageHeader } from "../../../../components/page_header";
import { UserAddOutlined } from '@ant-design/icons';
const AdminCreate: React.FC = () => {

    return (
        <div className="m-6 flex-grow  text-center ">
            <PageHeader
                title="Новий адміністратор"
                icon={<UserAddOutlined className="text-2xl"/>}
            />
            <div className="bg-white p-5">

                <span className="text-black">New_admin</span>
            </div>
        </div>)
};

export default AdminCreate;