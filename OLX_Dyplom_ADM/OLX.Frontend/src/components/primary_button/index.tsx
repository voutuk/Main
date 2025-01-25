import React from 'react'
import { PrimaryButtonProps } from './props'
import { Button } from 'antd'
import './style.scss'

const PrimaryButton: React.FC<PrimaryButtonProps> = ({ onButtonClick = () => { }, className = '', title,  brColor = '#FFBA00', bgColor = '#FFBA00', fontColor = '#3A211C', isLoading, htmlType = "button" }) => {
  return (
    <div className="primary-button" >
      <Button
        loading={isLoading}
        onClick={onButtonClick}
        htmlType={htmlType}
        style={{
          backgroundColor: bgColor,
          color: fontColor,
          borderColor:brColor
        }}
        className={`primary-button rounded-[8px] min-w-[180px] min-h-[30px] text-adaptive-text font-normal font-montserrat leading-[28px] ${className}`}>
        {title}
      </Button>
    </div>
  )
}

export default PrimaryButton