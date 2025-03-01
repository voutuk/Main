export const paginatorConfig = {
    pagination: {
        defaultPageSize: 10,
        defaultCurrent: 1,
        pageSizeOptions: [10, 20, 25, 30],
        showSizeChanger: true,
        locale: { items_per_page: " / на cторінці" },
        showTotal: (total:number, range:number[]) =>
            <div className="d-flex gap-2">
                <span className=" fw-bold"> { range[0]} </span>
                    < span > -</span>
                    < span className=" fw-bold" > { range[1]} </span>
                    < span > із </span>
                    < span className=" fw-bold" > { total } </span>
                    </div>
    },
}