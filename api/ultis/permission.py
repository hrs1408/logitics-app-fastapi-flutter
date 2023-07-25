from fastapi import Depends, HTTPException
from sqlalchemy.orm import Session

from config import get_db
from models.user import User
from repositories.user_repository import UserRepository


def check_permission_role_admin(id: int, db: Session = Depends(get_db)):
    check_user = UserRepository.find_by_id(db, User, id)
    if not check_user:
        raise HTTPException(status_code=404, detail="User not found or not login")
    if check_user.user_role != "admin" and check_user.user_role != "supper_admin":
        raise HTTPException(status_code=403, detail="Permission denied")
    if not check_user.is_active or check_user.is_active is False or check_user.is_active == 0 or check_user.is_active == "0":
        raise HTTPException(status_code=403, detail="User is de-active")


def check_permission_role_supper_admin(id: int, db: Session = Depends(get_db)):
    check_user = UserRepository.find_by_id(db, User, id)
    if not check_user:
        raise HTTPException(status_code=404, detail="User not found or not login")
    if check_user.user_role != "supper_admin":
        raise HTTPException(status_code=403, detail="Permission denied")
    if not check_user.is_active or check_user.is_active is False or check_user.is_active == 0 or check_user.is_active == "0":
        raise HTTPException(status_code=403, detail="User is de-active")
