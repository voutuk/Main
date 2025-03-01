import React from 'react'
import { useNavigate } from 'react-router-dom';
import { BackButton } from '../../../../components/buttons/back_button';
import PrimaryButton from '../../../../components/buttons/primary_button';

const PasswordChangeConfirmPage: React.FC = () => {
    const navigate = useNavigate();
    return (
        <div className="mx-auto flex flex-col gap-[6vh]  w-[50%] justify-center">
            <h2 className='text-[#3A211C]  font-unbounded text-adaptive-text font-medium'>На вашу електронну пошту направлено лист для зміни паролю</h2>
            <PrimaryButton
                title='На головну'
                onButtonClick={() => navigate('/')}
                className='w-full h-[5vh]' isLoading={false}
            />
            <BackButton className='text-adaptive-input-form-error-text' title='Назад'/>
        </div>
    )
}
export default PasswordChangeConfirmPage;