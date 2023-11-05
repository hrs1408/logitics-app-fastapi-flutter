import datetime
from typing import List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from uuid import UUID

from config import get_db
from models.branch import Headquarter, Port
from models.invoice import Invoice, Voyage, History
from models.user import User
from repositories.branch_repository import HeadquarterRepository, PortRepository
from repositories.invoice_repository import InvoiceRepository, VoyageRepository, HistoryRepository
from repositories.jwt_repository import JWTBearer
from repositories.user_repository import UserRepository, UserAddressRepository
from schemas.invoice_schema import InvoiceCreateSchema, ChangeStatusSchema
from schemas.schema import ResponseSchema
from ultis.permission import check_permission_role_admin
from ultis.security import get_current_user

invoice_route = APIRouter(
    prefix="/invoice",
    tags=["Invoice"],
)


@invoice_route.get("/", dependencies=[Depends(JWTBearer())])
def get_all_invoice(id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    invoices = InvoiceRepository.find_all(db, Invoice)
    return ResponseSchema.from_api_route(status_code=200, data=invoices).dict(exclude_none=True)


@invoice_route.get("/{invoice_id}", dependencies=[Depends(JWTBearer())])
def get_invoice_by_id(invoice_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    invoice = InvoiceRepository.find_by_id(db, Invoice, invoice_id)
    if not invoice:
        raise HTTPException(status_code=404, detail="Invoice not found")
    return ResponseSchema.from_api_route(status_code=200, data=invoice).dict(exclude_none=True)


@invoice_route.get("/user/{user_id}", dependencies=[Depends(JWTBearer())])
def get_invoice_by_user_id(user_id: int, db: Session = Depends(get_db)):
    invoices = InvoiceRepository.find_by_user_id(db, user_id)
    if not invoices:
        raise HTTPException(status_code=404, detail="Invoice not found")
    return ResponseSchema.from_api_route(status_code=200, data=invoices).dict(exclude_none=True)


@invoice_route.get("/delivery-status/{delivery_status}", dependencies=[Depends(JWTBearer())])
def get_invoice_by_delivery_status(delivery_status: str, db: Session = Depends(get_db)):
    voyages = VoyageRepository.find_by_delivery_status(db, delivery_status)
    if not voyages:
        raise HTTPException(status_code=404, detail="Voyage not found")
    invoices = []
    for voyage in voyages:
        invoice = InvoiceRepository.find_by_id(db, Invoice, voyage.invoice_id)
        invoices.append(invoice)
    return ResponseSchema.from_api_route(status_code=200, data=invoices).dict(exclude_none=True)


@invoice_route.post("/create", dependencies=[Depends(JWTBearer())])
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
    if invoice_create.shipping_type != "fast" and invoice_create.shipping_type != "normal" and invoice_create.shipping_type != "slow":
        raise HTTPException(status_code=400, detail="Shipping type is invalid")
    if invoice_create.kind_of_goods != "document" and invoice_create.kind_of_goods != "food" and invoice_create.kind_of_goods != "other":
        raise HTTPException(status_code=400, detail="Kind of goods is invalid")
    if invoice_create.payment != "payment_sender" and invoice_create.payment != "payment_receiver":
        raise HTTPException(status_code=400, detail="Payment is invalid")
    if invoice_create.show_goods != "dstg" and invoice_create.show_goods != "stg" and invoice_create.show_goods != "ttg":
        raise HTTPException(status_code=400, detail="Show goods is invalid")
    if invoice_create.delivery_status != "created" and invoice_create.delivery_status != "shipping" and invoice_create.delivery_status != "delivered" and invoice_create.delivery_status != "canceled":
        raise HTTPException(status_code=400, detail="Delivery status is invalid")
    invoice_created = Invoice(
        user_id=invoice_create.user_id,
        user_address_id=invoice_create.user_address_id,
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
        length=invoice_create.length,
        commodity_value=invoice_create.commodity_value,
        cod_money=invoice_create.cod_money,
        kind_of_goods=invoice_create.kind_of_goods,
        payment=invoice_create.payment,
        show_goods=invoice_create.show_goods,
        requirement_other=invoice_create.requirement_other,
        paided=invoice_create.paided,
        fee=invoice_create.fee
    )
    invoice_ctd = InvoiceRepository.insert(db, invoice_created)
    voyage_create = Voyage(
        invoice_id=invoice_ctd.id,
        headquarter_id=invoice_create.headquarter_id,
        port_id=invoice_create.port_id,
        delivery_status=invoice_create.delivery_status,
        pickup_staff_id=invoice_create.pick_up_staff_id,
        delivery_staff_id=invoice_create.delivery_staff_id,
        vehicle_id=invoice_create.vehicle_id,
        created_at=datetime.datetime.now()
    )
    voyage_ctd = VoyageRepository.insert(db, voyage_create)
    return ResponseSchema.from_api_route(status_code=200, data=voyage_ctd).dict(exclude_none=True)


@invoice_route.put("/change-status/{invoice_id}", dependencies=[Depends(JWTBearer())])
def change_status_invoice(invoice_id: int, status: ChangeStatusSchema, db: Session = Depends(get_db)):
    invoice = InvoiceRepository.find_by_id(db, Invoice, invoice_id)
    voyage = VoyageRepository.find_by_invoice_id(db, invoice_id)
    print(status)
    if not invoice or not voyage:
        raise HTTPException(status_code=404, detail="Invoice not found")
    if status.delivery_status != "created" and status.delivery_status != "shipping" and status.delivery_status != "delivered" and status.delivery_status != "canceled":
        raise HTTPException(status_code=400, detail="Delivery status is invalid")
    voyage.delivery_status = status.delivery_status
    voyage_etd = VoyageRepository.update(db, voyage)
    return ResponseSchema.from_api_route(status_code=200, data=voyage_etd).dict(exclude_none=True)


@invoice_route.put("/cancel/{invoice_id}", dependencies=[Depends(JWTBearer())])
def cancel_invoice(invoice_id: int, db: Session = Depends(get_db)):
    invoice = InvoiceRepository.find_by_id(db, Invoice, invoice_id)
    voyage = VoyageRepository.find_by_invoice_id(db, invoice_id)
    if not invoice or not voyage:
        raise HTTPException(status_code=404, detail="Invoice not found")
    voyage.delivery_status = "canceled"
    voyage_etd = VoyageRepository.update(db, voyage)
    return ResponseSchema.from_api_route(status_code=200, data=voyage_etd).dict(exclude_none=True)


@invoice_route.put("/shipping/{invoice_id}", dependencies=[Depends(JWTBearer())])
def shipping_invoice(invoice_id: int, db: Session = Depends(get_db)):
    invoice = InvoiceRepository.find_by_id(db, Invoice, invoice_id)
    voyage = VoyageRepository.find_by_invoice_id(db, invoice_id)
    if not invoice or not voyage:
        raise HTTPException(status_code=404, detail="Invoice not found")
    voyage.delivery_status = "shipping"
    voyage_etd = VoyageRepository.update(db, voyage)
    return ResponseSchema.from_api_route(status_code=200, data=voyage_etd).dict(exclude_none=True)


@invoice_route.put("/delivered/{invoice_id}", dependencies=[Depends(JWTBearer())])
def delivered_invoice(invoice_id: int, db: Session = Depends(get_db)):
    invoice = InvoiceRepository.find_by_id(db, Invoice, invoice_id)
    voyage = VoyageRepository.find_by_invoice_id(db, invoice_id)
    if not invoice or not voyage:
        raise HTTPException(status_code=404, detail="Invoice not found")
    voyage.delivery_status = "delivered"
    voyage_etd = VoyageRepository.update(db, voyage)
    return ResponseSchema.from_api_route(status_code=200, data=voyage_etd).dict(exclude_none=True)


@invoice_route.put("/created/{invoice_id}", dependencies=[Depends(JWTBearer())])
def created_invoice(invoice_id: int, db: Session = Depends(get_db)):
    invoice = InvoiceRepository.find_by_id(db, Invoice, invoice_id)
    voyage = VoyageRepository.find_by_invoice_id(db, invoice_id)
    if not invoice or not voyage:
        raise HTTPException(status_code=404, detail="Invoice not found")
    voyage.delivery_status = "created"
    voyage_etd = VoyageRepository.update(db, voyage)
    return ResponseSchema.from_api_route(status_code=200, data=voyage_etd).dict(exclude_none=True)


@invoice_route.put("/change-port/{invoice_id}", dependencies=[Depends(JWTBearer())]
                   )
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


@invoice_route.get("/voyage/{invoice_id}", dependencies=[Depends(JWTBearer())])
def get_voyage_by_invoice_id(invoice_id: int, db: Session = Depends(get_db)):
    invoice = InvoiceRepository.find_by_id(db, Invoice, invoice_id)
    if not invoice:
        raise HTTPException(status_code=404, detail="Invoice not found")
    voyage = VoyageRepository.find_by_invoice_id(db, invoice_id)
    if not voyage:
        raise HTTPException(status_code=404, detail="Voyage not found")
    return ResponseSchema.from_api_route(status_code=200, data=voyage).dict(exclude_none=True)


@invoice_route.get("/invoice/branch/{branch_id}", dependencies=[Depends(JWTBearer())])
def get_voyage_by_branch_id(branch_id: int, db: Session = Depends(get_db)):
    headquarters = HeadquarterRepository.find_by_branch_id(db, branch_id)
    if not headquarters:
        raise HTTPException(status_code=404, detail="Headquarter not found")
    invoices = []
    for headquarter in headquarters:
        voyages = VoyageRepository.find_by_headquarter_id(db, headquarter.id)
        for voyage in voyages:
            invoice = InvoiceRepository.find_by_id(db, Invoice, voyage.invoice_id)
            invoices.append(invoice)
    return ResponseSchema.from_api_route(status_code=200, data=invoices).dict(exclude_none=True)


# Assign staff pickup and delivery
@invoice_route.put("/assign-staff/{invoice_id}/{staff_id}", dependencies=[Depends(JWTBearer())])
def assign_staff_invoice(invoice_id: int, staff_id: int, db: Session = Depends(get_db)):
    invoice = InvoiceRepository.find_by_id(db, Invoice, invoice_id)
    if not invoice:
        raise HTTPException(status_code=404, detail="Invoice not found")
    voyage = VoyageRepository.find_by_invoice_id(db, invoice_id)
    if not voyage:
        raise HTTPException(status_code=404, detail="Voyage not found")
    if staff_id != 0:
        user = UserRepository.find_by_id(db, User, staff_id)
        if not user:
            raise HTTPException(status_code=404, detail="User not found")
        if user.user_role != "user":
            raise HTTPException(status_code=404, detail="User is not staff")
        if user.user_position_id != 3 and user.user_position_id != 4 and user.user_position_id != 5:
            raise HTTPException(status_code=404, detail="User is not pickup or delivery staff")
    if staff_id == 0:
        voyage.pickup_staff_id = None
    else:
        print(staff_id)
        voyage.pickup_staff_id = staff_id
    voyage_etd = VoyageRepository.update(db, voyage)
    print(voyage_etd.pickup_staff_id)
    return ResponseSchema.from_api_route(status_code=200, data=voyage_etd).dict(exclude_none=True)


# get invoice by pickup staff id
@invoice_route.get("/pickup-staff/{staff_id}", dependencies=[Depends(JWTBearer())])
def get_invoice_by_pickup_staff_id(staff_id: int, db: Session = Depends(get_db)):
    user = UserRepository.find_by_id(db, User, staff_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    if user.user_role != "user":
        raise HTTPException(status_code=404, detail="User is not staff")
    if user.user_position_id != 3 and user.user_position_id != 4 and user.user_position_id != 5:
        raise HTTPException(status_code=404, detail="User is not pickup or delivery staff")
    voyages = VoyageRepository.find_by_pickup_staff_id(db, staff_id)
    if not voyages:
        raise HTTPException(status_code=404, detail="Voyage not found")
    invoices = []
    for voyage in voyages:
        invoice = InvoiceRepository.find_by_id(db, Invoice, voyage.invoice_id)
        invoices.append(invoice)
    return ResponseSchema.from_api_route(status_code=200, data=invoices).dict(exclude_none=True)


# get invoice by pickup staff id and status
@invoice_route.get("/pickup-staff/{staff_id}/{status}", dependencies=[Depends(JWTBearer())])
def get_invoice_by_pickup_staff_id_and_status(staff_id: int, status: str, db: Session = Depends(get_db)):
    user = UserRepository.find_by_id(db, User, staff_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    if user.user_role != "user":
        raise HTTPException(status_code=404, detail="User is not staff")
    if user.user_position_id != 3 and user.user_position_id != 4 and user.user_position_id != 5:
        raise HTTPException(status_code=404, detail="User is not pickup or delivery staff")
    voyages = VoyageRepository.find_by_pickup_staff_id_and_status(db, staff_id, status)
    invoices = []
    for voyage in voyages:
        invoice = InvoiceRepository.find_by_id(db, Invoice, voyage.invoice_id)
        invoices.append(invoice)
    return ResponseSchema.from_api_route(status_code=200, data=invoices).dict(exclude_none=True)


# change port and headquarter
# current voyage add to history
# create new voyage
@invoice_route.put("/change-port-headquarter/{invoice_id}/{port_id}/{headquarter_id}/{status}",
                   dependencies=[Depends(JWTBearer())])
def change_port_headquarter_invoice(invoice_id: int, port_id: int, headquarter_id: int, status: str,
                                    db: Session = Depends(get_db)):
    invoice = InvoiceRepository.find_by_id(db, Invoice, invoice_id)
    if not invoice:
        raise HTTPException(status_code=404, detail="Invoice not found")
    port = PortRepository.find_by_id(db, Port, port_id)
    if not port:
        raise HTTPException(status_code=404, detail="Port not found")
    headquarter = HeadquarterRepository.find_by_id(db, Headquarter, headquarter_id)
    if not headquarter:
        raise HTTPException(status_code=404, detail="Headquarter not found")
    voyage = VoyageRepository.find_by_invoice_id(db, invoice_id)
    if not voyage:
        raise HTTPException(status_code=404, detail="Voyage not found")
    voyage_history = History(
        voyage_id=voyage.id,
        headquarter_id=voyage.headquarter_id,
        port_id=voyage.port_id,
        delivery_status=voyage.delivery_status,
        pickup_staff_id=voyage.pickup_staff_id,
        delivery_staff_id=voyage.delivery_staff_id,
        vehicle_id=voyage.vehicle_id,
        created_at=voyage.created_at
    )
    voyage_history_etd = HistoryRepository.insert(db, voyage_history)
    # update current voyage
    voyage.headquarter_id = headquarter_id
    voyage.port_id = port_id
    voyage.delivery_status = status
    voyage.created_at = datetime.datetime.now()
    voyage_etd = VoyageRepository.update(db, voyage)
    return ResponseSchema.from_api_route(status_code=200, data=voyage_etd).dict(exclude_none=True)


@invoice_route.get("/history/{voyage_id}", dependencies=[Depends(JWTBearer())])
def get_history_by_voyage_id(voyage_id: int, db: Session = Depends(get_db)):
    histories = HistoryRepository.find_by_voyage_id(db, voyage_id)
    if not histories:
        raise HTTPException(status_code=404, detail="History not found")
    return ResponseSchema.from_api_route(status_code=200, data=histories).dict(exclude_none=True)


# find voyage and invoice without token and permission
@invoice_route.get("/voyage/{invoice_id}/no-token")
def get_voyage_by_invoice_id_no_token(invoice_id: int, db: Session = Depends(get_db)):
    invoice = InvoiceRepository.find_by_id(db, Invoice, invoice_id)
    if not invoice:
        raise HTTPException(status_code=404, detail="Invoice not found")
    voyage = VoyageRepository.find_by_invoice_id(db, invoice_id)
    if not voyage:
        raise HTTPException(status_code=404, detail="Voyage not found")
    return ResponseSchema.from_api_route(status_code=200, data=voyage).dict(exclude_none=True)


# find history voyage without token and permission
@invoice_route.get("/history/{voyage_id}/no-token")
def get_history_by_voyage_id_no_token(voyage_id: int, db: Session = Depends(get_db)):
    histories = HistoryRepository.find_by_voyage_id(db, voyage_id)
    if not histories:
        raise HTTPException(status_code=404, detail="History not found")
    return ResponseSchema.from_api_route(status_code=200, data=histories).dict(exclude_none=True)


# get invoice by branch and status
@invoice_route.get("/invoice/branch/{branch_id}/{status}", dependencies=[Depends(JWTBearer())])
def get_voyage_by_branch_id_and_status(branch_id: int, status: str, db: Session = Depends(get_db)):
    headquarters = HeadquarterRepository.find_by_branch_id(db, branch_id)
    if not headquarters:
        raise HTTPException(status_code=404, detail="Headquarter not found")
    invoices = []
    for headquarter in headquarters:
        voyages = VoyageRepository.find_by_headquarter_id_and_status(db, headquarter.id, status)
        for voyage in voyages:
            invoice = InvoiceRepository.find_by_id(db, Invoice, voyage.invoice_id)
            invoices.append(invoice)
    return ResponseSchema.from_api_route(status_code=200, data=invoices).dict(exclude_none=True)


# get invoice by branch all status
@invoice_route.get("/invoice/branch/{branch_id}/all-status", dependencies=[Depends(JWTBearer())])
def get_voyage_by_branch_id_all_status(branch_id: int, db: Session = Depends(get_db)):
    headquarters = HeadquarterRepository.find_by_branch_id(db, branch_id)
    if not headquarters:
        raise HTTPException(status_code=404, detail="Headquarter not found")
    invoices = []
    for headquarter in headquarters:
        voyages = VoyageRepository.find_by_headquarter_id(db, headquarter.id)
        for voyage in voyages:
            invoice = InvoiceRepository.find_by_id(db, Invoice, voyage.invoice_id)
            invoices.append(invoice)
    return ResponseSchema.from_api_route(status_code=200, data=invoices).dict(exclude_none=True)
