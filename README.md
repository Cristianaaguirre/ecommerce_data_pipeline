# E-commerce Data Pipeline

Proyecto personal de ingeniería de datos: tomo CSV de un e-commerce, los limpio y los dejo listos para analizar.

🚧 En construcción.

---

## 🎯 El caso de negocio

Para darle sentido al pipeline, propongo el siguiente caso:

> *El dueño de e-commerce en España, con algunos archivos csv que llegaron a él, quiere ver cual es el estado actual de su negocio, si esta perdiendo dinero, donde invertir, etc*

Lo que necesita:

| # | Necesidad | Preguntas que debe poder responder |
|---|-----------|------------------------------------|
| 1 | **Saber cómo vamos** | ¿Cuánto vendimos este mes y cómo se compara con el anterior y con el mismo mes del año pasado? ¿Estamos creciendo? |
| 2 | **Saber qué se vende y qué no** | ¿Qué productos y categorías dejan más plata? ¿Cuáles están en stock sin moverse? |
| 3 | **Saber quiénes son los clientes y de dónde vienen** | ¿Qué canal (Google, Facebook, email, referidos) trae los mejores clientes y no solo los más baratos? ¿Los VIP compran realmente más? ¿En qué ciudades conviene invertir? |

Y dos preocupaciones de fondo:

- **Cancelaciones y devoluciones:** una parte importante de los pedidos no se completa. ¿Cuánto cuesta eso y en qué productos o clientes se concentra?
- **Confianza en el número:** si hoy hay dos cifras de ventas distintas, no se decide nada. Hace falta **una sola versión de la verdad**, y que el pipeline avise qué datos están mal en vez de esconderlos.

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
- [x] Estructura del repo
- [x] Bronze
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
