import { Rule } from "antd/es/form"

export interface FormInputProps {
    label: string,
    name: string,
    rules?: Rule[],
    inputType?: string,
    placeholder: string,
    className?:string
    dependencies?:any
}