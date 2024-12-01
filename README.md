# AI-Assisted Facade Generator

基于AI辅助的建筑立面生成工具，用于从建筑照片快速生成精确的2D立面图。

## 项目概述

本项目提供了一套完整的工作流程，用于：
1. 分析建筑照片
2. 推理建筑尺寸
3. 生成MAXScript脚本
4. 在3ds Max中创建精确的2D立面图

## 目录结构

```
.
├── docs/                      # 文档
│   ├── AI_Facade_Generator_Guide.md    # 完整使用指南
│   └── FacadeAnalysisTemplate.md       # 照片分析模板
│
├── scripts/                   # MAXScript脚本
│   ├── FacadeUtils.ms        # 基础工具库
│   └── examples/             # 示例脚本
│       └── SimpleFacade.ms   # 简单立面示例
│
└── README.md                 # 项目说明
```

## 快速开始

1. 准备工作
   - 安装3ds Max
   - 准备建筑立面照片
   - 确认关键参考尺寸（如门高2100mm）

2. 使用流程
   - 按照分析模板收集建筑信息
   - 使用AI助手分析照片并生成脚本
   - 在3ds Max中执行生成的脚本

## 技术特点

- 使用毫米(mm)作为标准单位
- 在XZ平面（y=0）上生成立面图
- 外轮廓逆时针，内轮廓顺时针
- 模块化的脚本结构

## 依赖环境

- Autodesk 3ds Max
- MAXScript支持

## 注意事项

- 建议使用正面、光线充足的建筑照片
- 需要至少一个已知的参考尺寸
- 生成的是2D立面轮廓，需要手动进行3D建模

## 许可证

[选择合适的开源许可证]

## 贡献指南

欢迎提交Issue和Pull Request来帮助改进项目。
