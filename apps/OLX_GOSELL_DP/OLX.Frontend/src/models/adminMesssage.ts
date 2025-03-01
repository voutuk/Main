export interface IAdminMesssage {
    id:number
    content: string
    userName: string
    userId: number
    readed: boolean
    subject: string
}

export interface IAdminMesssageCreationModel {
    content: string
    userId?: number
    subject: string
    userIds?:number[]
}