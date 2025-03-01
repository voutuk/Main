import { Spin } from "antd";

const GlobalFallback: React.FC = () => {
  return (
       <Spin size="large" fullscreen spinning={true} />
  );
};

export default GlobalFallback;