from typing import List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from config import get_db
from models.branch import Headquarter, Port
from models.invoice import Invoice, Voyage
from models.user import User
from repositories.branch_repository import HeadquarterRepository, PortRepository
from repositories.invoice_repository import InvoiceRepository, VoyageRepository
from repositories.jwt_repository import JWTBearer
from repositories.user_repository import UserRepository, UserAddressRepository
from schemas.invoice_schema import InvoiceSchema, InvoiceCreateSchema
from schemas.schema import ResponseSchema
from schemas.voyage_schema import VoyageSchema, VoyageSchemaBase
from ultis.permission import check_permission_role_admin
from ultis.security import get_current_user

invoice_route = APIRouter(
    prefix="/invoice",
    tags=["Invoice"],
)


@invoice_route.get("/", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[List[InvoiceSchema]])
def get_all_invoice(id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    invoices = InvoiceRepository.find_all(db, InvoiceSchema)
    return ResponseSchema.from_api_route(status_code=200, data=invoices).dict(exclude_none=True)


@invoice_route.get("/{invoice_id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[InvoiceSchema])
def get_invoice_by_id(invoice_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    invoice = InvoiceRepository.find_by_id(db, InvoiceSchema, invoice_id)
    if not invoice:
        raise HTTPException(status_code=404, detail="Invoice not found")
    return ResponseSchema.from_api_route(status_code=200, data=invoice).dict(exclude_none=True)


@invoice_route.get("/user/{user_id}", dependencies=[Depends(JWTBearer())],
                   response_model=ResponseSchema[List[InvoiceSchema]])
def get_invoice_by_user_id(user_id: int, db: Session = Depends(get_db)):
    invoices = InvoiceRepository.find_by_user_id(db, user_id)
    if not invoices:
        raise HTTPException(status_code=404, detail="Invoice not found")
    return ResponseSchema.from_api_route(status_code=200, data=invoices).dict(exclude_none=True)


@invoice_route.get("/delivery-status/{delivery_status}", dependencies=[Depends(JWTBearer())],
                   response_model=ResponseSchema[List[InvoiceSchema]])
def get_invoice_by_delivery_status(delivery_status: str, db: Session = Depends(get_db)):
    voyages = VoyageRepository.find_by_delivery_status(db, delivery_status)
    if not voyages:
        raise HTTPException(status_code=404, detail="Voyage not found")
    invoices = []
    for voyage in voyages:
        invoice = InvoiceRepository.find_by_id(db, Invoice, voyage.invoice_id)
        invoices.append(invoice)
    return ResponseSchema.from_api_route(status_code=200, data=invoices).dict(exclude_none=True)


@invoice_route.post("/create", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[InvoiceSchema])
def create_invoice(invoice_create: InvoiceCreateSchema, db: Session = Depends(get_db)):
    user = UserRepository.find_by_id(db, User, invoice_create.user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user_address = UserAddressRepository.find_by_user_id(db, user.id)
    if not user_address:
        raise HTTPException(status_code=404, detail="User address not found")
    headquarter = HeadquarterRepository.find_by_id(db, Headquarter, invoice_create.headquarter_id)
    if not headquarter:
        raise HTTPException(status_code=404, detail="Headquarter not found")
    if invoice_create.shipping_type != "fast" or invoice_create.shipping_type != "normal" or invoice_create.shipping_type != "slow":
        raise HTTPException(status_code=400, detail="Shipping type is invalid")
    if invoice_create.kind_of_goods != "document" or invoice_create.kind_of_goods != "food" or invoice_create.kind_of_goods != "other":
        raise HTTPException(status_code=400, detail="Kind of goods is invalid")
    if invoice_create.payment != "payment_sender" or invoice_create.payment != "payment_receiver":
        raise HTTPException(status_code=400, detail="Payment is invalid")
    if invoice_create.show_goods != "dstg" or invoice_create.show_goods != "stg" or invoice_create.show_goods != "ttg":
        raise HTTPException(status_code=400, detail="Show goods is invalid")
    if invoice_create.delivery_status != "created" or invoice_create.delivery_status != "shipping" or invoice_create.delivery_status != "delivered" or invoice_create.delivery_status != "canceled":
        raise HTTPException(status_code=400, detail="Delivery status is invalid")
    invoice_create = Invoice(
        user_id=invoice_create.user_id,
        user_address=invoice_create.user_address_id,
        rcv_full_name=invoice_create.rcv_full_name,
        rcv_phone_number=invoice_create.rcv_phone,
        rcv_address=invoice_create.rcv_address,
        rcv_ward=invoice_create.rcv_ward,
        rcv_province=invoice_create.rcv_province,
        shipping_type=invoice_create.shipping_type,
        weight=invoice_create.weight,
        width=invoice_create.width,
        height=invoice_create.height,
        quantity=invoice_create.quantity,
        commodity_value=invoice_create.commodity_value,
        code_money=invoice_create.cod_money,
        kind_of_goods=invoice_create.kind_of_goods,
        payment=invoice_create.payment,
        show_goods=invoice_create.show_goods,
        requirement_other=invoice_create.requirement_other,
        paided=invoice_create.paided
    )
    invoice_ctd = InvoiceRepository.insert(db, invoice_create)
    voyage_create = Voyage(
        invoice_id=invoice_ctd.id,
        headquarter_id=invoice_create.headquarter_id,
        port_id=invoice_create.port_id,
        delivery_status=invoice_create.delivery_status,
        pick_up_staff_id=invoice_create.pick_up_staff_id,
        delivery_staff_id=invoice_create.delivery_staff_id,
        vehicle_id=invoice_create.vehicle_id
    )
    voyage_ctd = VoyageRepository.insert(db, voyage_create)
    return ResponseSchema.from_api_route(status_code=200, data=voyage_ctd).dict(exclude_none=True)


@invoice_route.put("/change-status/{invoice_id}", dependencies=[Depends(JWTBearer())]
                   , response_model=ResponseSchema[VoyageSchema])
def change_status_invoice(invoice_id: int, status: VoyageSchemaBase, db: Session = Depends(get_db)):
    invoice = InvoiceRepository.find_by_id(db, Invoice, invoice_id)
    voyage = VoyageRepository.find_by_id(db, Voyage, invoice_id)
    if not invoice or not voyage:
        raise HTTPException(status_code=404, detail="Invoice not found")
    if status.delivery_status != "created" or status.delivery_status != "shipping" or status.delivery_status != "delivered" or status.delivery_status != "canceled":
        raise HTTPException(status_code=400, detail="Delivery status is invalid")
    if status.delivery_status == "took_goods":
        if not status.pick_up_staff_id:
            raise HTTPException(status_code=400, detail="Pick up staff id is invalid")
    if status.delivery_status == "shipping":
        if not status.pick_up_staff_id or not status.vehicle_id:
            raise HTTPException(status_code=400, detail="Pick up staff id or vehicle id is invalid")
    if status.delivery_status == "delivered":
        if not status.delivery_staff_id:
            raise HTTPException(status_code=400, detail="Delivery staff id is invalid")
    voyage.delivery_status = status.delivery_status
    voyage.pickup_staff_id = status.pick_up_staff_id
    voyage.delivery_staff_id = status.delivery_staff_id
    voyage.vehicle_id = status.vehicle_id
    voyage_etd = VoyageRepository.update(db, voyage)
    return ResponseSchema.from_api_route(status_code=200, data=voyage_etd).dict(exclude_none=True)


@invoice_route.put("/change-port/{invoice_id}", dependencies=[Depends(JWTBearer())],
                   response_model=ResponseSchema[VoyageSchema])
def change_port_invoice(invoice_id: int, port_id: int, db: Session = Depends(get_db)):
    invoice = InvoiceRepository.find_by_id(db, Invoice, invoice_id)
    if not invoice:
        raise HTTPException(status_code=404, detail="Invoice not found")
    port = PortRepository.find_by_id(db, Port, port_id)
    if not port:
        raise HTTPException(status_code=404, detail="Port not found")
    voyage = VoyageRepository.find_by_invoice_id(db, invoice_id)
    if not voyage:
        raise HTTPException(status_code=404, detail="Voyage not found")
    voyage.port_id = port_id
    voyage_etd = VoyageRepository.update(db, voyage)
    return ResponseSchema.from_api_route(status_code=200, data=voyage_etd).dict(exclude_none=True)
