import { useEffect, useState } from "react";
import { useNavigate, useSearchParams } from "react-router-dom";
import { Button, Spin } from "antd";
import { useConfirmEmailMutation } from "../../../redux/api/accountApi";

const EmailConfirmationPage: React.FC = () => {
  const [searchParams] = useSearchParams();
  const [emailConfirm, { isLoading }] = useConfirmEmailMutation();
  const navigate = useNavigate()
  const [confirmOk, setConfirmOk] = useState<boolean>(false)
  const [error, setError] = useState<boolean>(false)

  useEffect(() => {
    (async () => {
      const userId: string | null = searchParams.get("id")
      const token: string | null = searchParams.get("token")
      if (userId && token) {
        const result = await emailConfirm(({ id: userId, token: token }))
        if (!result.error) {
          setConfirmOk(true)
          return;
        }
      }
      setError(true)
    })()
  }, [searchParams])

  return (

    <div className="flex flex-1 flex-col h-full justify-center gap-3 items-center">
      <Spin size="small" spinning={isLoading} />
      <h3>{!confirmOk ? 'Підтвердження електронної пошти ....' : 'Електронну пошту успішно підтверджено !!!'}</h3>
      <h4 className='text-red-600' hidden={!error}>Сталася помилка підтвердження електронної пошти</h4>
      <Button className='w-1/6 mt-4' hidden={!confirmOk && !error} onClick={() => navigate('/auth')}>{confirmOk ? "Увійти" : "На головну"}</Button>
    </div>
  );
};

export default EmailConfirmationPage;