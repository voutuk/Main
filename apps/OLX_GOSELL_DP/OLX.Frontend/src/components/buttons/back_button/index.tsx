import { Button } from "antd"
import { LeftOutlined } from '@ant-design/icons';
import { useNavigate } from "react-router-dom";

interface BackButtonProps {
    title: string
    path?: string
    className?:string
}
export const BackButton: React.FC<BackButtonProps> = ({ title,className, path = '' }) => {
    const navigate = useNavigate()
    return (
        <Button onClick={() => path ? navigate(path) : navigate(-1)} className={`text-[#3A211C]  shadow-none font-montserrat border-none  p-0 ${className} `} variant="link">
            <div className='flex gap-2 items-center '>
                <LeftOutlined className='text-black  text-adaptive-input-form-error-text' />
                {title}
            </div>
        </Button>
    )
}