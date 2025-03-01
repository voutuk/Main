import { useEffect, useState } from "react";
import { useNavigate, useSearchParams } from "react-router-dom";
import { Spin } from "antd";
import { useConfirmEmailMutation } from "../../../redux/api/accountApi";
import PrimaryButton from "../../../components/buttons/primary_button";

const EmailConfirmationPage: React.FC = () => {
  const [searchParams] = useSearchParams();
  const [emailConfirm] = useConfirmEmailMutation();
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
    <div className="mx-auto my-auto w-[50%] text-center">
      {!confirmOk && !error
        ? <Spin size="large" spinning={true} />
        :
        <div className="mx-auto flex flex-col gap-[6vh]">
          <div className="flex flex-col gap-2 text-center">
            <span className="font-unbounded text-adaptive-login-header-text font-medium ">{confirmOk ? 'Ура!' : 'Щось не так :('}</span>
            <span className="font-montserrat text-adaptive-button-text">{confirmOk ? 'Реєстрація пройшла успішно :)' : 'Спробуйте, будьласка, ще раз'}</span>
          </div>
          <PrimaryButton
            title={confirmOk ? 'Увійти' : 'На головну'}
            onButtonClick={() => navigate(confirmOk ? '/auth' : '/')}
            className='w-full h-[5vh]' isLoading={false}
          />
        </div>}
    </div>
  );
};

export default EmailConfirmationPage;