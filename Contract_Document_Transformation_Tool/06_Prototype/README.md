# Prototype Runner

## 1. 目的

本目录存放 `Contract Document Transformation Tool` 的第一版可执行原型。

当前原型重点解决：

- 读取输入样例文件
- 基于文件名提取第一版字段
- 生成字段包
- 生成建议输出文件名
- 生成 review 清单副本
- 生成一份原型运行结果目录

## 2. 当前限制

- 目前主要基于文件名做字段抽取
- 尚未打通 PDF 正文抽取
- 尚未直接生成最终 Word / Excel 成品

## 3. 运行方式

在 PowerShell 中执行：

```powershell
powershell -ExecutionPolicy Bypass -File .\06_Prototype\Run_Prototype_1.ps1
```

## 4. 输出位置

运行后将在以下目录生成结果：

- `06_Prototype\generated\<timestamp>`

其中包含：

- `request_summary.json`
- `field_values.json`
- `generated_filenames.csv`
- `review_checklist.csv`
- `prototype_report.md`
