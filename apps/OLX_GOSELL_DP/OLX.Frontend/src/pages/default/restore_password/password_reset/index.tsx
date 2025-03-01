import { Button, Form } from "antd";
import { useNavigate, useSearchParams } from "react-router-dom";
import { useResetPasswordMutation } from "../../../../redux/api/accountApi";
import { LeftOutlined } from '@ant-design/icons';
import { useState } from "react";
import FormInput from "../../../../components/inputs/form_input";
import PrimaryButton from "../../../../components/buttons/primary_button";



const ResetPasswordPage: React.FC = () => {
    const [searchParams] = useSearchParams();
    const [resetPassword, { isLoading }] = useResetPasswordMutation();
    const navigate = useNavigate();
    const [changeOk, setChangeOk] = useState<boolean>(false)
    const [error, setError] = useState<boolean>(false)

    const onFinish = async (formResult: { password: string }) => {
        const userId: string | null = searchParams.get("id")
        const token: string | null = searchParams.get("token")
        if (userId && token) {
            const result = await resetPassword(({ userId: userId, token: token, password: formResult.password }))
            if (!result.error) {
                setChangeOk(true)
                return;
            }
        }
        setError(true)
    }

    return (
            <div className="mx-auto my-auto w-[50%]">
                {!error && !changeOk
                    ? <div className="flex flex-col  gap-[6vh] items-center justify-center ">
                        <div className='text-center'>
                            <h2 className='font-unbounded text-adaptive-login-header-text'>Новий пароль</h2>
                        </div>

                        <Form
                            className='w-full flex flex-col gap-[2vh]'
                            layout='vertical'
                            initialValues={{
                                remember: true
                            }}
                            onFinish={onFinish}
                        >
                            <FormInput
                                className='h-[5vh] min-h-[35px] text-adaptive-input-form-text text-[#9B7A5B]'
                                label='Пароль'
                                name='password'
                                placeholder='Пароль'
                                rules={[
                                    {
                                        required: true,
                                        message: 'Будь ласка, введіть пароль'
                                    },
                                    {
                                        pattern: /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?([^\\w\\s]|[_])).{6,}$/,
                                        message: 'Мінімум 6 символів,велика та мала літера,цифра,знак!',
                                    },
                                ]} />
                            <FormInput
                                className='h-[5vh] min-h-[35px] text-adaptive-input-form-text text-[#9B7A5B]'
                                label='Підтвердьте пароль'
                                name='passwordConfirmation'
                                placeholder='Підтвердіть пароль'
                                dependencies={['password']}
                                rules={[
                                    {
                                        required: true,
                                        message: 'Будьласка підтвердіть ваш пароль!',
                                    },
                                    ({ getFieldValue }) => ({
                                        validator(_, value) {
                                            if (!value || getFieldValue('password') === value) {
                                                return Promise.resolve();
                                            }
                                            return Promise.reject(new Error('Паролі не співпадають !'));
                                        }
                                    })
                                ]} />

                            <PrimaryButton
                                title='Продовжити'
                                htmlType='submit'
                                isLoading={isLoading}
                                className='w-full h-[5vh]'
                            />
                        </Form>
                        <Button onClick={() => navigate('/')} className='text-[#3A211C] text-adaptive-input-form-error-text shadow-none font-montserrat border-none  ml-[5px]' variant="link">
                            <div className='flex gap-2 items-center'>
                                <LeftOutlined className='text-black text-adaptive-input-form-error-text' />
                                На головну
                            </div>
                        </Button>
                    </div>
                    : <div className="mx-auto flex flex-col gap-[6vh]">
                        <div className="flex flex-col gap-2 text-center">
                            <span className="font-unbounded text-adaptive-login-header-text font-medium ">{changeOk ? 'Ура!' : 'Щось не так :('}</span>
                            <span className="font-montserrat text-adaptive-button-text">{changeOk ? 'Скидання паролю пройшло успішно :)' : 'Спробуйте, будьласка, ще раз'}</span>
                        </div>
                        <PrimaryButton
                            title={changeOk ? 'Увійти' : 'На головну'}
                            onButtonClick={() => navigate(changeOk ? '/auth' : '/')}
                            className='w-full h-[5vh]'
                            isLoading={false}
                        />
                    </div>}

            </div>
    );
};

export default ResetPasswordPage;