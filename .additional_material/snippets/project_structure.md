### Layered
```
lib
├── blocs
├── data
├── models
├── repositories
├── ui
└── main.dart
```

### Component
```
lib
├── componentA
├── componentB
├── componentC
├── componentD
|   ├── blocs
|   ├── data
|   ├── models
|   ├── repositories
|   └── ui
└── main.dart
```

### Tree-Like
```
lib
├── root
|   ├── blocs
|   ├── data
|   ├── models
|   ├── repositories
|   ├── pageA
|   ├── pageB
|   └── pageC
|       ├── blocs
|       ├── data
|       ├── models
|       ├── repositories
|       ├── featureC1
|       └── featureC2
└── main.dart
```