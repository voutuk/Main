import { ReactElement } from "react";

export interface MenuItem {
    key: string,
    icon: ReactElement,
    label: string | ReactElement,
    children?: MenuItem[]
}

export interface MenuData {
    selected: string,
    openKeys: string[]
}