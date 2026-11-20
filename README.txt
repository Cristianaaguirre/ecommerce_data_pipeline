# E-commerce Data Pipeline

Proyecto personal de ingeniería de datos: tomo CSV de un e-commerce, los limpio y los dejo listos para analizar.

🚧 En construcción.

---

## Sobre el proyecto

Pipeline que lleva los datos por tres capas (bronze, silver y gold) usando Python, DuckDB y SQL. Lo armo para practicar y mostrar cómo trabajo con datos reales y con problemas.

---

## Arquitectura

```
CSV → bronze → silver → gold → dashboard
```

- **Bronze:** los datos tal cual, en Parquet
- **Silver:** datos limpios y validados
- **Gold:** modelo listo para análisis

---

## Stack

Python · DuckDB · SQL · Parquet · pytest · Streamlit

---

## Estructura

```
├── data/raw/       # CSV originales
├── sql/            # transformaciones
├── src/            # scripts del pipeline
├── tests/          # tests
├── notebooks/      # exploración
├── dashboard/      # app de Streamlit
└── docs/           # diagramas y decisiones
```

---

## Progreso

- [x] Exploración de los datos
- [ ] Estructura del repo
- [ ] Bronze
- [ ] Silver
- [ ] Gold
- [ ] Tests de calidad
- [ ] Dashboard
- [ ] Documentación final

---

## Cómo correrlo

Próximamente.

---

## Autor

**Cristian Aguirre** · [LinkedIn](#) · [GitHub](#)
