# PostgreSQL & pgvector Rules

Guidelines for working with vector databases and relational data in a Python/FastAPI environment using SQLAlchemy and pgvector.

## Configuration & Schema
- Use the `pgvector` extension.
- Define vector columns with explicit dimensions: `Vector(1536)` (for OpenAI) or `Vector(768)` (for HuggingFace).
- Always use `Mapped` and `mapped_column` for SQLAlchemy 2.0+ models.
- Prefer `Float` or `Double` for vector components depending on precision requirements.

## Indexing (Performance)
- **HNSW (Hierarchical Navigable Small World):** Use for high search speed and good recall. 
  - Standard for most production use cases.
  - Requires more RAM than IVFFlat.
  - Example: `Index("idx_embedding", VectorColumn, postgresql_using="hnsw", postgresql_with={"m": 16, "ef_construction": 64}, postgresql_ops={"embedding": "vector_cosine_ops"})`.
- **IVFFlat:** Use for very large datasets if RAM is constrained.
  - Requires training (lists calculation).
- Always specify the distance operator in the index (e.g., `vector_cosine_ops`, `vector_l2_ops`, `vector_ip_ops`).

## Queries & Distance Metrics
- **Cosine Distance (`<=>`):** Use for semantic similarity (most common).
- **L2 Distance (`<->`):** Use for Euclidean distance.
- **Inner Product (`<#> `):** Use if vectors are normalized.
- Always implement pagination for vector search results.
- Limit the number of returned neighbors (e.g., `limit(10)` or `limit(50)`).

## Clean Architecture Integration
- Keep raw vector math and distance logic in the **Infrastructure** layer (Repository implementation).
- The **Domain** layer should work with high-level entities and should not know about pgvector-specific operators.
- Use DTOs to pass vectors if needed, but avoid exposing raw `numpy` arrays or large lists in the **Use Cases** layer unless necessary.

## Validation
- Verify vector dimensions before insertion.
- Ensure the database user has the `vector` extension enabled.
