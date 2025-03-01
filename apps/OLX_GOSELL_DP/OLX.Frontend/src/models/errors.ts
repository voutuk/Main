export interface IUserLockoutError {
    message: string | undefined
    Message: string | undefined
    UnlockTime: string | undefined,
    Email?:string | undefined
}

export interface IError {
    status: number
    message?: string;
    data?: IUserLockoutError | any
}