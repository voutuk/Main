import { PageHeader } from "../../../../components/page_header";
import { ProfileOutlined } from '@ant-design/icons';
const AdminApproveAdvertTable: React.FC = () => {

    return (
        <div className="m-6 flex-grow  text-center ">
            <PageHeader
                title="Не підтверджені"
                icon={<ProfileOutlined className="text-2xl" />}
            />
            <div className="bg-white p-5">

                <span className="text-black">Not_approved</span>
            </div>
        </div>)
};

export default AdminApproveAdvertTable;