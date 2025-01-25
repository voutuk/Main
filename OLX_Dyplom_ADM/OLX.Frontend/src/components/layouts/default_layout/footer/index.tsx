import { Divider } from "antd"
import { FacebookOutlined, InstagramOutlined } from '@ant-design/icons';
export const Footer: React.FC = () => {
    return (
        <div>
            <Divider className="p-0 m-0" />
            <div className='mx-[8vw] my-[4vh]  flex  justify-between flex-shrink-0' >
                <div className="flex flex-col h-[30vh] min-h-[100px] flex-wrap text-adaptive-text gap-3 text-[#BB8A52]">
                    <span className="mr-[6vw]">Допомога</span>
                    <span className="mr-[6vw]">Зворотній зв'язок</span>
                    <span className="mr-[6vw]">Платні послуги</span>
                    <span className="mr-[6vw]">Умови користування</span>
                    <span className="mr-[6vw]">Політика конфіденційності</span>
                    <span className="mr-[6vw]">Правила безпеки</span>
                    <span className="mr-[6vw]">Популярні запити</span>
                    <span className="mr-[6vw]">Робота</span>
                    <span className="mr-[6vw]">Як продавати?</span>
                    <span className="mr-[6vw]">Як купувати</span>
                    <span className="mr-[6vw]">Доставка</span>
                </div>
                <div className="flex gap-5 self-end">
                    <InstagramOutlined className="text-adaptive-footer-icons" />
                    <FacebookOutlined className="text-adaptive-footer-icons" />
                </div>
            </div>
        </div>)

}