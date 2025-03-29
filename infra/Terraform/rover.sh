doppler run -- terragrunt plan -out plan.out
doppler run -- terragrunt show -json plan.out > plan.json
MSYS_NO_PATHCONV=1 docker run --rm -it -p 9000:9000 -v "$(pwd)":/src/ im2nguyen/rover:latest -planJSONPath=plan.json -standalone true
rm plan.out plan.json