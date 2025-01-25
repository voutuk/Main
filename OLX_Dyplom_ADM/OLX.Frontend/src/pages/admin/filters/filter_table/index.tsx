import { Button, Input, Pagination, Popconfirm, Table, TableColumnsType, Tooltip } from "antd";
import { PageHeader } from "../../../../components/page_header";
import { FilterOutlined, SearchOutlined } from '@ant-design/icons';
import { paginatorConfig } from "../../../../utilities/pagintion_settings";
import { IFilter, IFilterPageRequest, IFilterValue } from "../../../../models/filter";
import { Key, useEffect, useState } from "react";
import { useGetFilterPageQuery } from "../../../../redux/api/filterApi";
import { ColumnType, TableProps } from "antd/es/table";
import { IconButton } from "@mui/material";
import { AddCircleOutline, CachedOutlined, DeleteForever, EditCalendar } from "@mui/icons-material";
import PageHeaderButton from "../../../../components/page_header_button";
import { useDeleteFilterMutation } from "../../../../redux/api/filterAuthApi";
import { toast } from "react-toastify";
import AdminFilterCreate from "../../../../components/drawers/filter_create";
const AdminFilterTable: React.FC = () => {

    const [isDrawerOpen, setIsDrawerOpen] = useState<boolean>(false)
    const [selectedFilter, setSelectedFilter] = useState<IFilter | undefined>();
    const [delFilter] = useDeleteFilterMutation();
    const [nameSearch, setNameSearch] = useState<string>('')
    const [pageRequest, setPageRequest] = useState<IFilterPageRequest>({
        size: paginatorConfig.pagination.defaultPageSize,
        page: paginatorConfig.pagination.defaultCurrent,
        sortKey: '',
        isDescending: false,
        searchName: "",
    })

    const { data, isLoading, refetch } = useGetFilterPageQuery(pageRequest)
    const getColumnSearchProps = (): ColumnType<IFilter> => ({
        filterDropdown: () => (
            <div style={{ padding: 8 }}>
                <Input
                    placeholder={`Пошук`}
                    value={nameSearch}
                    onChange={(e) => setNameSearch(e.target.value)}
                    style={{ width: 188, marginBottom: 8, display: 'block' }}
                />
                <div className="flex gap-2">
                    <Button
                        type="primary"
                        onClick={() => {
                            if (nameSearch !== '') {
                                setPageRequest((prev) => ({ ...prev, searchName: nameSearch }))
                            }
                        }}
                        size="small"
                        style={{ width: 90 }}
                    >
                        Знайти
                    </Button>
                    <Button
                        onClick={() => {
                            if (nameSearch !== '') {
                                setNameSearch('')
                                setPageRequest((prev) => ({ ...prev, searchName: '' }))
                            }
                        }}
                        size="small"
                        style={{ width: 90 }}
                    >
                        Очистити
                    </Button>
                </div>
            </div>
        ),
        filterIcon: () => (
            <SearchOutlined style={{ width: 20, color: nameSearch !== '' ? '#1890ff' : undefined }} />
        ),
    });

    const onTableChange: TableProps<IFilter>['onChange'] = (_pagination, _filters, sorter, extra) => {
        if (extra.action === 'sort') {
            let descending: boolean;
            let key: Key | undefined;
            if (Array.isArray(sorter)) {
                const firstSorter = sorter[0];
                descending = firstSorter.order === 'descend';
                key = firstSorter.columnKey;
            } else {
                descending = sorter.order === 'descend';
                key = sorter.columnKey;
            }
            setPageRequest((prev) => ({ ...prev, isDescending: descending, sortKey: key?.toString() }))
        }
    }

    const deleteFilter = async (filterId: number) => {
        const result = await delFilter(filterId);
        if (!result.error) {
            toast(`Фільтер успішно видалений`, {
                type: 'info'
            })
        }
    }

    const editFilter = (filter: IFilter) => {

        setIsDrawerOpen(true)
        setSelectedFilter(filter);
    }

    const onDrawerClose = () => {

        setIsDrawerOpen(false)
        setSelectedFilter(undefined);
    }

    const columns: TableColumnsType<IFilter> = [
        {
            title: 'ID',
            dataIndex: 'id',
            key: 'id',
            ellipsis: true,
            width: 50,
            fixed: 'left',
            align: 'center',
            sorter: true,
        },

        {
            title: "Назва",
            dataIndex: 'name',
            key: 'name',
            ellipsis: true,
            width: 'auto',
            sorter: true,
            fixed: 'left',
            ...getColumnSearchProps()
        },

        {
            title: "Значення",
            dataIndex: 'values',
            key: 'values',
            ellipsis: true,
            width: 'auto',
            render: (values: IFilterValue[]) =>
                <div className=" text-xs text-gray-500">
                    {values.map(x => x.value).join(' | ')}
                </div>

        },
        {
            key: 'actions',
            width: 100,
            render: (_, filter: IFilter) =>
                <div className='flex justify-around'>
                    <Tooltip title="Редагувати фільтр">
                        <IconButton onClick={() => { editFilter(filter) }} color="success" size="small">
                            <EditCalendar />
                        </IconButton>
                    </Tooltip>

                    <Tooltip title="Видалити фільтр">
                        <Popconfirm
                            title="Відалення фільтра"
                            description={`Ви впевненні що бажаєте видалити фільтр "${filter.name}"?`}
                            onConfirm={() => deleteFilter(filter.id)}
                            okText="Видалити"
                            cancelText="Відмінити"
                        >
                            <IconButton color="error" size="small">
                                <DeleteForever />
                            </IconButton>
                        </Popconfirm>
                    </Tooltip>
                </div>,
            fixed: 'right',
            align: 'center'
        }

    ];

    const onPaginationChange = (currentPage: number, pageSize: number) => {
        setPageRequest({ ...pageRequest, page: currentPage, size: pageSize })
    }

    useEffect(() => {
        (async () => {
            await refetch()
        })()
    }, [pageRequest])

    return (
        <div className="m-6 flex-grow  text-center overflow-hidden">
            {isDrawerOpen &&
                <AdminFilterCreate
                    open={isDrawerOpen}
                    onClose={onDrawerClose}
                    filter={selectedFilter} />}

            <PageHeader
                title="Фільтри"
                icon={<FilterOutlined className="text-2xl" />}
                buttons={[
                    <PageHeaderButton
                        key='add'
                        onButtonClick={() => setIsDrawerOpen(true)}
                        className="w-[35px] h-[35px] bg-green-700"
                        buttonIcon={<AddCircleOutline className="text-lg" />}
                        tooltipMessage="Додати фільтр"
                        tooltipColor="gray" />,
                    <PageHeaderButton
                        key='reload'
                        onButtonClick={refetch}
                        className="w-[35px] h-[35px] bg-sky-700"
                        buttonIcon={<CachedOutlined className="text-lg" />}
                        tooltipMessage="Перезавантажити"
                        tooltipColor="gray" />
                ]}
            />
            <Table<IFilter>
                size="small"
                rowKey="id"
                columns={columns}
                dataSource={data?.items}
                scroll={{ x: 'max-content' }}
                loading={isLoading}
                bordered
                pagination={false}
                showSorterTooltip={{ target: 'sorter-icon' }}
                onChange={onTableChange}
            />

            {((data?.total || 0) > paginatorConfig.pagination.defaultPageSize) &&
                <Pagination
                    align="center"
                    showSizeChanger
                    pageSizeOptions={paginatorConfig.pagination.pageSizeOptions}
                    locale={paginatorConfig.pagination.locale}
                    showTotal={paginatorConfig.pagination.showTotal}
                    current={pageRequest.page}
                    total={data?.total}
                    pageSize={pageRequest.size}
                    onChange={onPaginationChange}
                    className='mt-4' />
            }
        </div>
    )
};

export default AdminFilterTable;