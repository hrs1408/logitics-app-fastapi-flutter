from fastapi import FastAPI
from fastapi_responseschema import wrap_app_responses
from passlib.context import CryptContext
from sqlalchemy.orm import sessionmaker
from starlette.middleware.cors import CORSMiddleware
from starlette.staticfiles import StaticFiles

from database.database import engine
from models import user, vehicle, branch, invoice, timekeeping
from models.user import User
from repositories.timekeeping_detail_route import timekeeping_detail_route
from routes.auth_route import auth
from routes.branch_route import branch_r
from routes.headquarter_route import headquarter_route
from routes.port_route import port_route
from routes.position_route import position
from routes.timekeeping_route import timekeeping_route
from routes.user_route import user_route
from routes.vehicle_route import vehicle_route
from routes.warehouse_route import warehouse_route
from schemas.schema import Route

user.Base.metadata.create_all(bind=engine)
vehicle.Base.metadata.create_all(bind=engine)
branch.Base.metadata.create_all(bind=engine)
invoice.Base.metadata.create_all(bind=engine)
timekeeping.Base.metadata.create_all(bind=engine)
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
    manager_position = db.query(user.UserPosition).filter(user.UserPosition.position_name == "manager").first()
    if not manager_position:
        manager_position = user.UserPosition(position_name="manager")
        db.add(manager_position)
        db.commit()
        db.refresh(manager_position)
    warehouse_position = db.query(user.UserPosition).filter(user.UserPosition.position_name == "warehouse").first()
    if not warehouse_position:
        warehouse_position = user.UserPosition(position_name="warehouse")
        db.add(warehouse_position)
        db.commit()
        db.refresh(warehouse_position)
    driver_position = db.query(user.UserPosition).filter(user.UserPosition.position_name == "driver").first()
    if not driver_position:
        driver_position = user.UserPosition(position_name="driver")
        db.add(driver_position)
        db.commit()
        db.refresh(driver_position)
    delivery_position = db.query(user.UserPosition).filter(user.UserPosition.position_name == "delivery").first()
    if not delivery_position:
        delivery_position = user.UserPosition(position_name="delivery")
        db.add(delivery_position)
        db.commit()
        db.refresh(delivery_position)
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
        adminInfo = user.UserInformation(full_name="Admin")
        db.add(admin)
        db.commit()
        db.refresh(admin)
        adminInfo.user_id = admin.id
        db.add(adminInfo)
        db.commit()
        db.refresh(adminInfo)
    db.close()


origins = [
    "*",
    "http://localhost.tiangolo.com",
    "https://localhost.tiangolo.com",
    "http://localhost:3030",
    "http://localhost:40053",
    "https://hrs1408.web.app",
    "https://hrs1408.firebaseapp.com", ]

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
app.include_router(prefix="/api", router=branch_r)
app.include_router(prefix="/api", router=headquarter_route)
app.include_router(prefix="/api", router=warehouse_route)
app.include_router(prefix="/api", router=port_route)
app.include_router(prefix="/api", router=vehicle_route)
app.include_router(prefix="/api", router=timekeeping_route)
app.include_router(prefix="/api", router=timekeeping_detail_route)
app.mount("/medias", StaticFiles(directory="medias"), name="medias")
