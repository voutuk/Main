
import { DownOutlined, LogoutOutlined, MailOutlined, SettingOutlined, UserOutlined } from '@ant-design/icons';
import './style.scss'
import { Avatar, Badge, Dropdown, MenuProps } from 'antd'
import { Link } from 'react-router-dom';
import { Images } from '../../../../constants/images';
import { useSelector } from 'react-redux';
import { getUserDescr } from '../../../../utilities/common_funct';
import UserAvatar from '../../../user_avatar';
import { getRefreshToken, getUnreadedCount, getUser } from '../../../../redux/slices/userSlice';
import { useLogoutMutation } from '../../../../redux/api/accountApi';
import { useAppSelector } from '../../../../redux';
import { useEffect } from 'react';
import { useGetAdminMessagesQuery } from '../../../../redux/api/adminMessageApi';
import { useSignalR } from '../../../hendlers/signalR/signalRContext';



export const AdminHeader: React.FC = () => {
    const [logout] = useLogoutMutation();
    const signalRConnection = useSignalR();
    const user = useSelector(getUser)
    const refreshToken = useAppSelector(getRefreshToken)
    const unreadMesssageCount = useAppSelector(getUnreadedCount)
    const { refetch } = useGetAdminMessagesQuery();
    const items: MenuProps['items'] = [
        {
            icon: <UserOutlined />,
            label: <Link to={'/admin/rofile'}>Профіль</Link>,
            key: '0',
        },
        {
            icon: <SettingOutlined />,
            label: <Link to={'/admin/settings'}>Налаштування</Link>,
            key: '1',
        },
        {
            type: 'divider',
        },
        {
            icon: <LogoutOutlined />,
            label: 'Вийти',
            key: '3',
            onClick: async () => {
                await signalRConnection?.connection?.invoke("Disconnect");
                await logout(refreshToken || '').unwrap();
            }
        },
    ];

    useEffect(() => { refetch() }, [user])
    return (
        <div className='h-[60px] bg-header sticky top-0 items-center flex-shrink-0 flex justify-between z-50'  >
            <div className='flex gap-6 items-center'>
                <Avatar className='ml-3' size={46} src={Images.adminPanelImage} />
                <span>Адмінпанель</span>
            </div>
            <div className='flex gap-7 h-full'>
                <div className='flex gap-5 flex-shrink-0 items-center'>
                    <Badge count={unreadMesssageCount} size='small' className={unreadMesssageCount > 0 ? "animate-pulse" : ''}>
                        <MailOutlined className='text-xl text-white' />
                    </Badge>
                </div>
                <Dropdown menu={{ items }} trigger={['click']} className=' min-w-[180] px-5 cursor-pointer  flex-shrink-0 bg-orange-500 flex gap-2 justify-center items-center'>
                    <div>
                        <UserAvatar size={40} user={user} />
                        <span className='flex-shrink-0  text-base text-nowrap'>{user ? getUserDescr(user) : ''}</span>
                        <DownOutlined />
                    </div>
                </Dropdown>

            </div>
        </div>
    )
}