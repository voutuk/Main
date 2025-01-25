import { PageHeader } from "../../../../components/page_header";
import { ProfileOutlined } from '@ant-design/icons';
const AdminAdvertTable: React.FC = () => {

    return (
        <div className="m-6 flex-grow  text-center ">
            <PageHeader
                title="Всі оголошення"
                icon={<ProfileOutlined className="text-2xl" />}
            />
            <div className="bg-white p-5">

                <span className="text-black">All_adverts</span>
            </div>
        </div>)
};

export default AdminAdvertTable;