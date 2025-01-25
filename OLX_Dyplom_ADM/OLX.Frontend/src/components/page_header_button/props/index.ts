import { ReactElement } from "react"

export interface PageHeaderButtonProps {
    tooltipMessage?: string | undefined
    onButtonClick: Function
    className?:string
    buttonIcon?:ReactElement,
    tooltipColor?:  string | undefined,
    disabled?:boolean
    
}