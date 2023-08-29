from typing import List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from config import get_db
from repositories.invoice_repository import InvoiceRepository
from repositories.jwt_repository import JWTBearer
from schemas.invoice_schema import InvoiceSchema
from schemas.schema import ResponseSchema
from ultis.permission import check_permission_role_admin
from ultis.security import get_current_user

invoice = APIRouter(
    prefix="/invoice",
    tags=["Invoice"],
)


@invoice.get("/", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[List[InvoiceSchema]])
def get_all_invoice(id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    invoices = InvoiceRepository.find_all(db, InvoiceSchema)
    return ResponseSchema.from_api_route(status_code=200, data=invoices).dict(exclude_none=True)


@invoice.get("/{invoice_id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[InvoiceSchema])
def get_invoice_by_id(invoice_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    invoice = InvoiceRepository.find_by_id(db, InvoiceSchema, invoice_id)
    if not invoice:
        raise HTTPException(status_code=404, detail="Invoice not found")
    return ResponseSchema.from_api_route(status_code=200, data=invoice).dict(exclude_none=True)


