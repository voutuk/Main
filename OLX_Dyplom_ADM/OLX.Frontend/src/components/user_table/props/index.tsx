import { TablePaginationConfig } from "antd";
import { FilterValue, SorterResult, TableCurrentDataSource } from "antd/es/table/interface";
import { IOlxUser, IOlxUserPageRequest, PageResponse } from "../../../models/user";

export interface UserTableProps {
    isLoading: boolean,
    onTableChange: (
        pagination: TablePaginationConfig,
        filters: Record<string, FilterValue | null>,
        sorter: SorterResult<IOlxUser> | SorterResult<IOlxUser>[],
        extra: TableCurrentDataSource<IOlxUser>
    ) => void;
    page: number,
    total: number,
    size: number,
    onPaginationChange: (currentPage: number, pageSize: number) => void,
    onRowSelection: (userIds: number[]) => void,
    onSearch: (value: IOlxUserPageRequest) => void,
    actions: (_: any, user: IOlxUser) => JSX.Element,
    pageRequest: IOlxUserPageRequest,
    pageResponse: PageResponse<IOlxUser> | undefined,
    selectedUsers: number[],
    selected?: boolean

}