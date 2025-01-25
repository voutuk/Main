export interface PrimaryButtonProps {
    onButtonClick?: () => void,
    title: string,
    bgColor?: string,
    fontColor?: string
    className?:string
    brColor?:string,
    isLoading: boolean
    htmlType?:  "button" | "submit" | "reset"
}