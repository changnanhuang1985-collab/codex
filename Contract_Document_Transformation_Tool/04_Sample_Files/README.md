# Sample Files 说明

## 1. 目的

本目录用于统一存放 `Contract Document Transformation Tool` 项目的输入样例、输出样例、样例对照和回归样例。

团队后续所有模板提炼、字段识别、规则设计、review 和回归验证，原则上都应基于本目录下的样例开展。

## 2. 目录结构

- `01_Input_Samples`
- `02_Output_Samples`
- `03_Input_Output_Pairs`
- `04_Regression_Baseline`
- `05_Review_Pack`

## 3. 使用原则

- 输入样例和输出样例尽量成对保存
- 文件名应体现样例编号和用途
- 若涉及敏感信息，应先脱敏再入库
- 新增样例时，建议同步更新对应说明文件
- 回归基线样例不得随意覆盖，应保留版本说明

## 4. 推荐命名方式

推荐使用以下命名：

- `SAMPLE-001_Input.xxx`
- `SAMPLE-001_Output.xxx`
- `SAMPLE-001_Notes.md`
- `REG-001_Output_Baseline.xxx`

## 5. 一句话说明

这个目录是后续工具设计、样本分析、规则沉淀和回归验证的基础资产区。
