import "./style.scss"
import { PageHeaderProps } from "./props";

export const PageHeader: React.FC<PageHeaderProps> = ({ title, icon, buttons }) => {

    return (
        <div className="text-white flex justify-between w-full items-center page-header h-[50px] rounded-t-md px-6">
            <div className="flex gap-5">
                {icon}
                <span className="text-xl">{title}</span>
            </div>
            <div className="flex gap-3">
                {buttons}
            </div>
        </div>)
}