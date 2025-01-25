import { Button, Form, Input } from "antd";
import { useNavigate, useSearchParams } from "react-router-dom";
import { toast } from "react-toastify";
import { useResetPasswordMutation } from "../../../../redux/api/accountApi";



const ResetPasswordPage: React.FC = () => {
    const [searchParams] = useSearchParams();
    const [resetPassword,{isLoading}] = useResetPasswordMutation();
    const navigator = useNavigate();

    const onFinish = async (formResult: { password: string }) => {
        const userId: string | null = searchParams.get("id")
        const token: string | null = searchParams.get("token")
        if (userId && token) {
            const result = await resetPassword(({ userId: userId, token: token, password: formResult.password }))
            if (!result.error) {
                toast("Пароль успішшно змінений", {
                    type: "success"
                })
                navigator('/auth')
            }
        }
    }
    
    return (
        <Form
            layout='vertical'
            style={{
                maxWidth: 300,
            }}
            initialValues={{
                remember: true,
            }}
            onFinish={onFinish}
            className='mx-auto text-center'
            autoComplete="off"
        >
            <Form.Item
                hasFeedback
                label="Пароль"
                name="password"
                rules={[
                    {
                        required: true,
                        message: 'Будьласка введіть пароль!',
                    },
                    {
                        pattern: /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?([^\\w\\s]|[_])).{6,}$/,
                        message: 'Невірний пароль...!',
                    },
                    {
                        min: 6,
                        message: 'Пароль має містити не менше 6 символів!',
                    },
                    {
                        max: 16,
                        message: 'Пароль має містити не більше 16 символів!',
                    },

                ]}
            >
                <Input.Password />
            </Form.Item>

            <Form.Item
                label="Підтвердіть пароль"
                dependencies={['password']}
                name='confirmation'
                hasFeedback
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
                            return Promise.reject(new Error('Пароль підтвердження не співпадає з введенним паролем!'));
                        },
                    }),
                ]}
            >
                <Input.Password />
            </Form.Item>

            <Button loading={isLoading} className='mt-3' style={{ width: 200 }} type="primary" htmlType="submit">
                Оновити пароль
            </Button>
        </Form>
    );
};

export default ResetPasswordPage;