Number of threads: 500

1. Get Category Http request: `/api/Category/get`

2. Get Image Http request: `/images/400_tuzo3p4z.h20.webp`

3. Get Filters Http request: `/api/Filter/get`

3. Get Advert Http request: `/advert/9`

### Docker stats

| CONTAINER NAME  | NAME                   | CPU %   | MEM USAGE / LIMIT   | MEM %  | NET I/O            |
|--------------|------------------------|--------|--------------------|-------|-------------------|
| Backend | olx_container          | 187.23% | 337.4MiB / 7.708GiB | 4.27%  | 26.5GB / 8.31GB   |
| Database | postgresDB             | 116.11% | 379.4MiB / 7.708GiB | 4.81%  | 327MB / 26.4GB    |
| Frontend | olx_client_container   | 2.68%   | 5.406MiB / 7.708GiB | 0.07%  | 28.9MB / 92.9MB   |

### JMeter

| Label            | # Samples | Average | Min  | Max   | Std. Dev. | Error % | Throughput | Received KB/sec | Sent KB/sec | Avg. Bytes |
|-----------------|----------|---------|------|-------|----------|---------|------------|----------------|-------------|------------|
| Категорії       | 85386    | 1794    | 51   | 12525 | 494.74   | 0.245%  | 101.16105  | 5969.79        | 13.30       | 60429.0    |
| Get webp        | 85177    | 1379    | 5    | 2909  | 305.02   | 0.197%  | 100.93162  | 1591.66        | 14.46       | 16148.1    |
| api get filters | 85009    | 1682    | 15   | 12432 | 461.69   | 0.145%  | 100.73362  | 1630.59        | 13.06       | 16575.7    |
| get front page  | 84886    | 7       | 0    | 302   | 10.10    | 0.000%  | 100.65347  | 93.48          | 11.99       | 951.0      |
| **TOTAL**       | 340458   | 1217    | 0    | 12525 | 804.23   | 0.147%  | 403.35519  | 9284.78        | 52.81       | 23571.3    |


