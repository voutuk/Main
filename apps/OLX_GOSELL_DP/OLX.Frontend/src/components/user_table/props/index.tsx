import { IOlxUser, IOlxUserPageRequest, PageResponse } from "../../../models/user";

export interface UserTableProps {
    isLoading: boolean,
    page: number,
    total: number,
    size: number,
    onRowSelection: (userIds: number[]) => void,
    actions: (_: any, user: IOlxUser) => JSX.Element,
    pageRequest: IOlxUserPageRequest,
    pageResponse: PageResponse<IOlxUser> | undefined,
    selectedUsers: number[],
    selected?: boolean

}