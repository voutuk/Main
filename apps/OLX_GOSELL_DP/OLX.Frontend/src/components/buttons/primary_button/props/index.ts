export interface PrimaryButtonProps {
    onButtonClick?: () => void,
    title: string,
    bgColor?: string,
    fontSize?: string,
    fontColor?: string
    className?:string
    brColor?:string,
    isLoading: boolean
    htmlType?:  "button" | "submit" | "reset"
    disabled?:boolean
}