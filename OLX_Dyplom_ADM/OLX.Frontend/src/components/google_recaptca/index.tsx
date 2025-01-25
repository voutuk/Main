import { GoogleReCaptchaProvider } from "react-google-recaptcha-v3"
import { APP_ENV } from "../../constants/env"

type ChildProps = {
    children: string | JSX.Element | JSX.Element[]
}

const ReCaptcha: React.FC<ChildProps> = ({ children }: ChildProps) => {
    return (
        <GoogleReCaptchaProvider reCaptchaKey={APP_ENV.RECAPTCHA_SITE_KEY}>
            {children}
        </GoogleReCaptchaProvider>)
}

export default ReCaptcha
