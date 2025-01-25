import React from 'react'
import { Input, Form } from 'antd';
import { FormInputProps } from './props';
import './style.scss'

const FormInput: React.FC<FormInputProps> = ({ className = '', label, name, rules = [], inputType = "text", placeholder }) => {
  return (
    <div className='primary-input'>
      <Form.Item
        label={<label className='text-[#3A211C] text-adaptive-input-form-text font-unbounded font-medium leading-5 '>{label}</label>}
        name={name}
        rules={rules.map(rule => ({
          ...rule,
          message: (
            <span className="font-montserrat text-[#BB8A52] text-adaptive-input-form-error-text  font-normal leading-5 underline">
              {rule.message}
            </span>
          ),
        }))}
        required={false}
        className='text-left mb-[3vh]'
      >
        {name != 'password' ?
          <Input type={inputType} placeholder={placeholder} className={`rounded-[8px] text-opacity-50 font-montserrat font-normal leading-6 ${className}`} />
          :
          <Input.Password type={inputType} placeholder={placeholder} className={`rounded-[8px] text-opacity-50 font-montserrat font-normal leading-6 ${className}`} />
        }
      </Form.Item>
    </div>

  )
}

export default FormInput