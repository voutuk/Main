import { ReactNode } from "react"

export interface CollpaseProps {
    title?: string,
    className?: string
    children?: ReactNode
    onOpen?: (e: any) => void
    isOpen?: boolean
}
