import React from "react";
import { PageHeaderButtonProps } from "./props";
import Tooltip from "@mui/material/Tooltip/Tooltip";


const PageHeaderButton: React.FC<PageHeaderButtonProps> = ({ tooltipMessage, onButtonClick, buttonIcon, className, tooltipColor, disabled }) => {

    return (
        <>{!disabled &&
            <Tooltip
                color={tooltipColor ? tooltipColor : "geekblue"}
                title={tooltipMessage}>
                <div className={`flex items-center flex-shrink-0 flex-grow justify-center cursor-pointer rounded-full ${className}`}
                    onClick={() => onButtonClick()}>
                    {buttonIcon}
                </div>
            </Tooltip>}</>
    );
};

export default PageHeaderButton;