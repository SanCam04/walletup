# WalletUp - Arquitectura Hexagonal

Este proyecto implementa una arquitectura hexagonal (Ports & Adapters) organizada por features, utilizando Flutter con Riverpod para la gestión de estado.

## Estructura del Proyecto

```
lib/
├── app/                          # Configuración de la aplicación
│   ├── constants/               # Constantes de la aplicación
│   └── theme/                   # Configuración de temas
├── core/                        # Abstracciones compartidas
│   ├── domain/
│   │   ├── entities/           # Entidad base
│   │   ├── failures/           # Tipos de fallos
│   │   ├── usecases/          # Interfaz base para casos de uso
│   │   └── value_objects/     # Objeto de valor base
│   └── presentation/
│       ├── state/             # Estado base y notificadores
│       └── widgets/           # Widgets comunes (loading, error)
└── features/                    # Features organizadas por dominio
    ├── wallet/                 # Feature de billeteras
    │   ├── domain/
    │   │   ├── entities/      # Entidades del dominio
    │   │   ├── repositories/  # Puertos/Interfaces
    │   │   ├── services/      # Servicios de dominio
    │   │   └── value_objects/ # Objetos de valor
    │   ├── application/
    │   │   └── usecases/      # Casos de uso
    │   ├── infrastructure/
    │   │   ├── datasources/   # Fuentes de datos
    │   │   ├── models/        # Modelos de datos
    │   │   └── repositories/  # Implementación de puertos
    │   └── presentation/
    │       ├── notifiers/     # StateNotifiers
    │       ├── pages/         # Páginas/Pantallas
    │       ├── providers/     # Proveedores de Riverpod
    │       ├── state/         # Estados específicos
    │       └── widgets/       # Widgets específicos
    └── transaction/            # Feature de transacciones
        └── ... (misma estructura)
```

## Principios de la Arquitectura

### 1. Separación por Capas

#### Domain Layer (Dominio)
- **Entidades**: Objetos de negocio centrales (`Wallet`, `Transaction`)
- **Value Objects**: Objetos inmutables que representan conceptos del dominio (`WalletName`, `WalletBalance`)
- **Repositorios**: Interfaces/puertos que definen cómo acceder a los datos
- **Servicios de Dominio**: Lógica de negocio que no pertenece a una entidad específica

#### Application Layer (Aplicación)
- **Casos de Uso**: Orquestan las operaciones de negocio (`CreateWallet`, `GetTransactions`)
- **No contiene lógica de infraestructura**

#### Infrastructure Layer (Infraestructura)
- **Adaptadores**: Implementaciones concretas de los puertos del dominio
- **Fuentes de Datos**: Acceso a datos locales/remotos
- **Modelos**: Representación de datos para persistencia

#### Presentation Layer (Presentación)
- **StateNotifiers**: Gestión de estado con Riverpod
- **Páginas y Widgets**: Interfaz de usuario
- **Proveedores**: Configuración de dependencias con Riverpod

### 2. Reglas de Dependencia

- **Domain** no depende de ninguna capa externa
- **Application** solo depende de **Domain**
- **Infrastructure** implementa interfaces de **Domain** y **Application**
- **Presentation** depende de **Application** y usa **Infrastructure** a través de inyección de dependencias

### 3. Gestión de Estado

Se utiliza **StateNotifier + Riverpod** para:
- Gestión de estado reactiva
- Inyección de dependencias
- Separación de concerns
- Testing facilitado

## Features Implementadas

### Wallet Feature
- **Entidades**: `Wallet`
- **Value Objects**: `WalletName`, `WalletBalance`
- **Casos de Uso**: `GetWallets`, `CreateWallet`, `UpdateWallet`, `DeleteWallet`
- **UI**: Lista de billeteras, creación, eliminación

### Transaction Feature
- **Entidades**: `Transaction`
- **Value Objects**: `TransactionAmount`, `TransactionDescription`, `TransactionType`
- **Casos de Uso**: `GetTransactions`, `CreateTransaction`, `DeleteTransaction`
- **UI**: Preparado para implementar (estructura completa)

## Tecnologías Utilizadas

- **Flutter**: Framework de UI
- **flutter_riverpod**: Gestión de estado e inyección de dependencias
- **dartz**: Programación funcional (Either para manejo de errores)
- **equatable**: Comparación de objetos
- **json_annotation**: Serialización JSON
- **uuid**: Generación de identificadores únicos

## Ventajas de esta Arquitectura

1. **Testabilidad**: Fácil testing por separación de concerns
2. **Mantenibilidad**: Código organizado y fácil de modificar
3. **Escalabilidad**: Fácil agregar nuevas features
4. **Independencia**: Domain no depende de frameworks externos
5. **Flexibilidad**: Fácil cambiar implementaciones de infraestructura

## Comandos Útiles

```bash
# Instalar dependencias
flutter pub get

# Generar código (modelos JSON)
flutter packages pub run build_runner build

# Ejecutar análisis estático
flutter analyze

# Ejecutar tests
flutter test

# Ejecutar la aplicación
flutter run
```

## Próximos Pasos

1. Implementar persistencia real (SQLite/Hive)
2. Agregar más casos de uso para transacciones
3. Implementar navegación entre pantallas
4. Agregar validaciones más robustas
5. Implementar sincronización de datos
