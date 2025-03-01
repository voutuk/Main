export interface IArea {
    description: string;
    regionType: string;
    ref: string;
}

export interface IRegion {
    description: string;
    regionType: string;
    ref: string;
    areaRef: string;
}

export interface ISettlement {
    description: string;
    ref: string;
    region: string;
    area: string;
}

export interface IWirehouse{
    ref:string;
    description:string;
    settlementRef:string;
    phone:string;
}