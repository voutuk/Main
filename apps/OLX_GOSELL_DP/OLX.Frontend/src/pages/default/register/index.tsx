import React, { useState } from 'react'
import { Button, Checkbox, Form } from 'antd';
import { IRegisterRequest } from '../../../models/account';
import { Link, useNavigate } from 'react-router-dom';
import { useGoogleReCaptcha } from 'react-google-recaptcha-v3';
import { useRegisterMutation } from '../../../redux/api/accountApi';
import { Images } from '../../../constants/images';
import FormInput from '../../../components/inputs/form_input';
import PrimaryButton from '../../../components/buttons/primary_button';

const action: string = 'register'

const RegisterPage: React.FC = () => {
  const navigate = useNavigate();
  const [register, { isLoading }] = useRegisterMutation();
  const { executeRecaptcha } = useGoogleReCaptcha();
  const [agree, setAgree] = useState<boolean>(false)

  const onFinish = async (registerModel: IRegisterRequest) => {
    if (executeRecaptcha) {
      registerModel.recapthcaToken = await executeRecaptcha(action);
      registerModel.action = action
      const result = await register(registerModel);
      if (!result.error) {
        navigate('confirm')
      }
    }
  }

  return (
    <div id='#login' className="mx-auto flex flex-col items-center w-[50%] justify-center text-center">
      <div className='text-center'>
        <img alt="logo" className="h-[6vh] min-h-[45px] w-full" src={Images.logo} />
        <h2 className='text-[#3A211C] mb-[6vh] font-montserrat text-adaptive-button-text font-normal'>Твій перший крок до нових можливостей!</h2>
      </div>

      <Form
        className='w-full text-start'
        layout='vertical'
        initialValues={{
          remember: true
        }}
        onFinish={onFinish}
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


        <Form.Item
          name="agree"
          valuePropName="checked">

          <Checkbox onChange={(event) => { setAgree(event.target.checked) }}>
            <div className='text-adaptive-input-form-error-text my-[2vh] flex flex-col items-start text-[#3A211C] font-montserrat'>
              <span> Створюючи профіль ви погоджуєтеся з</span>
              <Link
                to=''
                className='underline'
              >
                Умовами користування
              </Link>
            </div>
          </Checkbox>
        </Form.Item>

        <PrimaryButton
          title='Зареєструватися'
          htmlType='submit'
          isLoading={isLoading}
          className='w-full h-[5vh]'
          disabled={!agree}
        />

      </Form>
      <div className='flex justify-center items-center mt-[6vh] text-adaptive-input-form-error-text'>
        <p className='text-[#9B7A5B] font-montserrat'>Вже маєте акаунт?</p>
        <Button onClick={() => navigate('/auth')} className='text-[#3A211C] text-adaptive-input-form-error-text shadow-none font-montserrat border-none  ml-[5px]' variant="link">Увійти тут</Button>
      </div>
    </div>

  )
}
export default RegisterPage;