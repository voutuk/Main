import React from 'react'
import { Input, Form } from 'antd';
import { FormInputProps } from './props';
import './style.scss'

const FormInput: React.FC<FormInputProps> = ({dependencies, className = '', label, name, rules = [], inputType = "text", placeholder }) => {
  return (
    <div className='primary-input'>
      <Form.Item
        label={<label className='text-[#3A211C] text-adaptive-input-form-text font-unbounded font-medium leading-5 '>{label}</label>}
        name={name}
        dependencies={dependencies}
        rules={rules}
        required={false}
        className='text-left mb-[3vh]'
      >
        {(name !== 'password' && name !== 'passwordConfirmation')
          ? <Input type={inputType} placeholder={placeholder} className={`rounded-[8px] text-opacity-50 font-montserrat font-normal leading-6 ${className}`} />
          : <Input.Password  type={inputType} placeholder={placeholder} className={`rounded-[8px]  text-opacity-50 font-montserrat font-normal leading-6 ${className}`} />
        }
      </Form.Item>
    </div>

  )
}

export default FormInput