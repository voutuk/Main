import { IAdminMesssage } from "./adminMesssage"

export interface IUser {
    id: number
    firstName: string
    lastName: string
    email: string
    photo: string
    exp: number
    roles: string[],
    phone: string
}

export interface IUserState {
    user: IUser | null
    auth: IUserAuth
    token: string | null
    refreshToken: string | null
    messages: IAdminMesssage[]
}

export interface IUserAuth {
    isAdmin: boolean
    isUser: boolean
    isAuth: boolean,
    remember: boolean,
    roles: string[]
    location: string
}

export interface IAuthResponse {
    accessToken: string,
    refreshToken: string
}

export interface ILoginRequest {
    email: string,
    password: string
    recapthcaToken: string
    action: string
}

export interface ILoginLocalRequest extends ILoginRequest {
    remember: boolean | undefined
}

export interface IGoogleLoginRequest {
    token: string,
    remember: boolean | undefined
}

export interface IEmailConfirmationModel {
    id: string
    token: string
}

export interface IResetPasswordModel {
    userId: string
    token: string
    password: string
}

export interface IUserLockModel{
    userIds:number[]
    lock:boolean
    lockoutEndDate?:string
    lockReason?:string
}

