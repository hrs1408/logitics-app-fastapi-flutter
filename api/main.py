from fastapi import FastAPI
from fastapi_responseschema import wrap_app_responses
from passlib.context import CryptContext
from sqlalchemy.orm import sessionmaker
from starlette.middleware.cors import CORSMiddleware
from starlette.staticfiles import StaticFiles

from database.database import engine
from models import user
from models.user import User
from routes.auth_route import auth
from routes.position_route import position
from routes.user_route import user_route
from schemas.schema import Route

user.Base.metadata.create_all(bind=engine)
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

app = FastAPI(
    title="Logistics API",
    description="This is a very fancy project, with auto docs for the API and everything",
    version="2.5.0",
)
wrap_app_responses(app, Route)


@app.on_event("startup")
def start_up_event():
    db = SessionLocal()
    root_position = db.query(user.UserPosition).filter(user.UserPosition.position_name == "root").first()
    if not root_position:
        root_position = user.UserPosition(position_name="root")
        db.add(root_position)
        db.commit()
        db.refresh(root_position)
    client_position = db.query(user.UserPosition).filter(user.UserPosition.position_name == "client").first()
    if not client_position:
        client_position = user.UserPosition(position_name="client")
        db.add(client_position)
        db.commit()
        db.refresh(client_position)
    root_user = db.query(User).filter(User.email == "admin@gmail.com").first()
    if not root_user:
        admin = User(email="admin@gmail.com", hashed_password=pwd_context.hash("Admin@123"),
                     user_role=user.UserRole.SUPPER_ADMIN, is_active=True, user_position_id=root_position.id)
        db.add(admin)
        db.commit()
        db.refresh(admin)
    db.close()


origins = [
    "http://localhost.tiangolo.com",
    "https://localhost.tiangolo.com",
    "http://localhost:3000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(prefix="/api", router=auth)
app.include_router(prefix="/api", router=user_route)
app.include_router(prefix="/api", router=position)
app.mount("/medias", StaticFiles(directory="medias"), name="medias")
