from database.database import SessionLocal


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


SECRET_KEY = "YYI3RozyIwRqu285uv1lnPPGPYHqvRek"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 10080  # 1 hour
REFRESH_TOKEN_EXPIRE_MINUTES = 10080  # 7 days
