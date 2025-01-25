import { Spin } from "antd";

const GlobalFallback: React.FC = () => {
  return (
    <div className=" flex-1 flex justify-center items-center">
      <Spin size="large" spinning={true} />
    </div>

  );
};

export default GlobalFallback;