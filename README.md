# xnsure-protocol

## xNsure Protocol

xNsure provide AMM European call and put options by introducing AMM tools to non-prefessional option sellers as well as AMM liquidity providers. 

3 Core components of xNsure:

- Clean Issuing and Destroying Procedures with 100% Margin
  - Single-sided Iron Condor Option Series, Higher Margin Efficiency
  - European Options Fixed Liquidation Time
- AMM Pools with 2 different user groups:
  - Sellers as AMM Liquidity Providers 
  - Buyers with risk management demand with 
- Payout procedures with different priorities

### NsurePutToken：发行 WETH/USDC 看空期权

#### 欧式Capped PUT期权 + 现货结算 + 全额质押

-   Underlying Asset: WETH
-   Strike Asset：USDC
-   Strike Price: 400
-   Capped Max Payoff: 80
-   Capped Price: 320

#### 合约到期

-   到期前: 可以 mint() / burn() / exercise()行权  (*注：不考虑burn*)
-   到期后: 可以withdraw()赎回

#### 流程

1. minter创建Capped PUT期权产品Token
    -   使用USDC作为抵押资产，锁定 m 个
    -   铸造NsurePutToken，n个 (n>=1)
    -   比例 m/n = Capped Max Payoff = 80

2. admin上架uniswap，提供流动性
    -   将NsurePutToken上架uniswap
    -   添加流动性池: 定价 NsurePutToken:WETH = 0.1

3. (可选?是的，倾向于不burn)minter可以收回期权产品Token
   -    支付NsurePutToken, n个
   -    返回USDC, m个
   -    比例 m/n = StrikePrice

4. AMM交易
   -    buyer用户在uniswap购买NsurePutToken，支付WETH
   -    市场给 NsurePutToken:WETH 定价为 Spot Price

5. (到日期前)行权 # 不支持美式所以可忽略
   -    支付NsurePutToken, m个
   -    支付WETH，k个 （可以去掉）
   -    比例 m/k = （可以去掉）
   -    获USDC数量, n = m * StrikePrice（可以去掉）
   -    返回USDC, n个（可以去掉）
   -    burn NsurePutToken, m个

6. (到日期后)admin停止交易
   -    在uniswap remove流动性
   -    AMM下架

7. (到日期后)行权 # 欧式行权
   -    支付NsurePutToken m个
   -    **按照 m * min(max(400-price,0),80)返回USDC**
   -    返回USDC, n1个 （忽略）
   -    返回WETH, n2个（被行权后，导致USDC不足） （忽略）
   -    burn NsurePutToken

#### PnL计算

行权收益 = m * min(max(400-price,0),80)返回USDC


