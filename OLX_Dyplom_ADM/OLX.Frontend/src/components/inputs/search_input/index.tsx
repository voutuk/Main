import React from 'react'
import './style.scss'
import { Input } from 'antd'
import { SearchOutlined } from '@mui/icons-material'
import { SearchInputProps } from './props'

const SearchInput: React.FC<SearchInputProps> = ({ className='' }) => {
    return (
        <div className='search-input'>
            <Input className={` rounded-[1.1vh] ${className} pl-[1vw] min-h-[30px] w-[38vw] h-[5vh] text-[#BB8A52] text-adaptive-text leading-6`}
                
                placeholder="Пошук"
                prefix={<SearchOutlined style={{ fontSize: "clamp(20px, 4vh, 36px)"}} />} />
        </div>
    )
}

export default SearchInput