import { Form } from "antd";
import { useNavigate } from "react-router-dom";
import { useSendPasswordResetEmailMutation } from "../../../../redux/api/accountApi";
import { BackButton } from "../../../../components/buttons/back_button";
import FormInput from "../../../../components/inputs/form_input";
import PrimaryButton from "../../../../components/buttons/primary_button";

const ForgotPasswordPage: React.FC = () => {
  const [passFogot, { isLoading }] = useSendPasswordResetEmailMutation()
  const navigate = useNavigate();

  const sendPassResetEmail = async (formResult: { email: string }) => {
    const result = await passFogot(formResult.email);
    if (!result.error) {
      navigate('passwordconfirm')
    }
  }

  return (
    
      <div className="mx-auto my-auto w-[50%]">
        <div className="flex flex-col gap-2 mb-[8vh] text-center">
          <span className="font-unbounded text-adaptive-login-header-text ">Забули пароль?</span>
          <span className="font-montserrat text-adaptive-text">Не хвилюйтесь, ми надішлемо електронний лист з підтвердженням скидання паролю</span>
        </div>
        <Form
          className='w-full'
          layout='vertical'
          initialValues={{
            remember: true
          }}
          onFinish={sendPassResetEmail}
        >
          <FormInput
            className='h-[5vh] min-h-[35px] text-adaptive-input-form-text text-[#9B7A5B]'
            label='Електронна пошта'
            name='email'
            placeholder='example@gmail.com'
            rules={[
              { required: true, message: 'Будь ласка, введіть електронну пошту' },
              { type: 'email', message: 'Невірний формат електронної пошти' }
            ]} />
          <PrimaryButton
            htmlType='submit'
            className='w-full h-[5vh] mt-[2vh] mb-[8vh]'
            title='Скинути пароль'
            isLoading={isLoading} />
        </Form>
        <BackButton  className='text-adaptive-input-form-error-text' title="Назад"/>
      </div>
  );
};

export default ForgotPasswordPage;