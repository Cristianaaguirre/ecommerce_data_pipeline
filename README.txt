# 🛒 E-commerce Data Pipeline

Pipeline de ingeniería de datos de punta a punta construido sobre un dataset de e-commerce: ingesta de archivos CSV, limpieza y validación de calidad, modelado dimensional y visualización de métricas de negocio.

> 🚧 **Estado del proyecto:** en construcción. Este README se actualiza a medida que avanzo con cada etapa (ver [Hoja de ruta](#-hoja-de-ruta)).

---

## 🎯 Objetivo

Construir un pipeline reproducible que transforme datos crudos y con problemas de calidad en un modelo analítico confiable, aplicando buenas prácticas de ingeniería de datos:

- Arquitectura en capas (**bronze → silver → gold**)
- Transformaciones en **SQL** versionadas y legibles
- **Reglas de calidad** con tabla de cuarentena para filas rechazadas
- **Modelo dimensional** (esquema estrella)
- Pipeline ejecutable con **un solo comando**

---

## 🏗️ Arquitectura

```
CSV (raw)  →  BRONZE  →  SILVER  →  GOLD  →  Dashboard
              Parquet    limpio y    modelo     Streamlit
              tal cual   tipado      dimensional
                           ↓
                      cuarentena
                (filas rechazadas + motivo)
```

| Capa | Qué contiene |
|------|--------------|
| **Raw** | Los CSV originales, sin modificar |
| **Bronze** | Copia fiel en Parquet + metadatos de carga (`_ingested_at`, `_source_file`) |
| **Silver** | Datos limpios, tipados y validados |
| **Gold** | Dimensiones, hechos y tablas listas para análisis |

> 📌 Diagrama de arquitectura: *(pendiente, se agregará en `docs/arquitectura.png`)*

---

## 🧰 Stack

- **Python**: orquestación y control de calidad
- **DuckDB**: motor analítico y base de datos local
- **SQL**: transformaciones (limpieza y modelado)
- **Parquet**: formato de almacenamiento columnar
- **pytest**: tests automáticos
- **Streamlit**: dashboard *(planificado)*

---

## 📂 Dataset

9 archivos CSV de un e-commerce:

| Archivo | Descripción | Filas aprox. |
|---------|-------------|--------------|
| `clientes.csv` | Clientes, ciudad, canal de adquisición, VIP | 5.000 |
| `pedidos.csv` | Cabecera de pedidos, fecha, importe, estado | 20.000 |
| `lineas_pedido.csv` | Detalle de productos por pedido | 30.000 |
| `productos.csv` | Catálogo con precio y stock | 200 |
| `categorias.csv` | Categorías de producto | 5 |
| `vendedores.csv` | Vendedores por equipo y categoría | 10 |
| `empleados.csv` | Empleados por departamento | 100 |
| `ventas_diarias.csv` | Ventas agregadas por día (2024) | 365 |
| `ventas_mensuales.csv` | Ventas agregadas por mes (2023-2024) | 24 |

---

## 🔍 Hallazgos iniciales de calidad de datos

El dataset contiene problemas intencionales (o reales) que el pipeline debe detectar y tratar:

- **Valores nulos** en `email`, `ciudad`, `canal_adquisicion`, `es_vip` (clientes) y en `estado` e `importe` (pedidos).
- **Filas anómalas** al final de `pedidos` y `clientes` (registros casi vacíos o incompletos).
- **Tipos inconsistentes**: ids y cantidades que llegan como decimales; `es_vip` con valores mezclados.
- **Cobertura parcial del detalle**: `lineas_pedido` solo cubre ~15.000 de los ~20.000 pedidos.
- **Importes que no concilian**: `pedidos.importe` no coincide con `cantidad × precio` del producto ni con la suma de sus líneas.
- **Precios distintos** entre `lineas_pedido.precio_unitario` y `productos.precio`.

Cada decisión tomada sobre estos problemas se documentará en [`docs/decisiones.md`](docs/decisiones.md).

---

## 🗺️ Hoja de ruta

- [x] Exploración inicial y perfilado de los datos
- [ ] Estructura del repositorio y entorno
- [ ] **Bronze:** ingesta de CSV a Parquet
- [ ] **Silver:** limpieza, tipado y tabla de cuarentena
- [ ] **Gold:** modelo dimensional (`dim_cliente`, `dim_producto`, `dim_fecha`, `fact_pedidos`)
- [ ] Reglas de calidad y tests con pytest
- [ ] Pipeline ejecutable con un solo comando
- [ ] Dashboard en Streamlit
- [ ] Diagramas y documentación final
- [ ] *(Mejora futura)* Migración de transformaciones a dbt
- [ ] *(Mejora futura)* Orquestación con Prefect / Dagster

---

## 📁 Estructura del repositorio

```
ecommerce-data-pipeline/
├── data/
│   └── raw/            # CSV originales
├── sql/                # transformaciones (profiling, silver, gold)
├── src/                # scripts de ingesta, transformación y calidad
├── tests/              # tests automáticos
├── notebooks/          # exploración inicial
├── dashboard/          # app de Streamlit
└── docs/               # diagramas y decisiones
```

---

## ▶️ Cómo ejecutarlo

*(Se completará cuando el pipeline esté listo.)*

```bash
git clone https://github.com/<tu-usuario>/ecommerce-data-pipeline.git
cd ecommerce-data-pipeline
pip install -r requirements.txt
make run
```

---

## 👤 Autor

**Cristian Aguirre**
Data Engineer · Salta, Argentina

- LinkedIn: *(agregar link)*
- GitHub: *(agregar link)*