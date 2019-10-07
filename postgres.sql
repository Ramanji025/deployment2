-- Table: public.book_org

-- DROP TABLE public.book_org;

CREATE TABLE public.book_org
(
    id bigint NOT NULL,
    org_name character varying COLLATE pg_catalog."default",
    gstn character varying COLLATE pg_catalog."default",
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    phone character varying COLLATE pg_catalog."default",
    active character varying(5) COLLATE pg_catalog."default",
    address character varying COLLATE pg_catalog."default",
    CONSTRAINT book_ord_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.book_org
    OWNER to postgres;

-- Table: public.book_branch

-- DROP TABLE public.book_branch;

CREATE TABLE public.book_branch
(
    id bigint NOT NULL,
    branch_name character varying(100) COLLATE pg_catalog."default",
    address character varying COLLATE pg_catalog."default",
    gstn character varying(50) COLLATE pg_catalog."default",
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    phone character varying(15) COLLATE pg_catalog."default",
    active character varying(5) COLLATE pg_catalog."default",
    book_org bigint,
    CONSTRAINT book_branch_pk PRIMARY KEY (id),
    CONSTRAINT fk_org FOREIGN KEY (book_org)
        REFERENCES public.book_org (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.book_branch
    OWNER to postgres;
	
	
	
-- Table: public.book_user

-- DROP TABLE public.book_user;

CREATE TABLE public.book_user
(
    id bigint NOT NULL,
    user_name character varying(50) COLLATE pg_catalog."default",
    first_name character varying(50) COLLATE pg_catalog."default",
    last_name character varying(50) COLLATE pg_catalog."default",
    password character varying COLLATE pg_catalog."default",
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    active character varying(5) COLLATE pg_catalog."default",
    user_org bigint,
    CONSTRAINT book_user_pkey PRIMARY KEY (id),
    CONSTRAINT book_user_user_org_fkey FOREIGN KEY (user_org)
        REFERENCES public.book_org (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.book_user
    OWNER to postgres;
	
	
	
	
	-- Table: public.book_groups

-- DROP TABLE public.book_groups;

CREATE TABLE public.book_groups
(
    id bigint NOT NULL,
    code character varying COLLATE pg_catalog."default",
    group_name character varying(50) COLLATE pg_catalog."default",
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    group_org bigint,
    active character varying(5) COLLATE pg_catalog."default",
    CONSTRAINT book_groups_pkey PRIMARY KEY (id),
    CONSTRAINT book_groups_group_org_fkey FOREIGN KEY (group_org)
        REFERENCES public.book_org (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.book_groups
    OWNER to postgres;
	
	
-- Table: public.book_ledgers

-- DROP TABLE public.book_ledgers;

CREATE TABLE public.book_ledgers
(
    id bigint NOT NULL,
    code character varying COLLATE pg_catalog."default",
    ledger_name character varying(50) COLLATE pg_catalog."default",
    led_group bigint,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    opening_type character varying(10) COLLATE pg_catalog."default",
    opening_balance double precision,
    phone character varying COLLATE pg_catalog."default",
    town character varying COLLATE pg_catalog."default",
    office_address character varying COLLATE pg_catalog."default",
    bill_address character varying COLLATE pg_catalog."default",
    bank_name character varying(50) COLLATE pg_catalog."default",
    bank_city character varying COLLATE pg_catalog."default",
    acc_number character varying COLLATE pg_catalog."default",
    ifsc character varying(10) COLLATE pg_catalog."default",
    active character varying(5) COLLATE pg_catalog."default",
    led_org bigint,
    CONSTRAINT book_ledgers_pkey PRIMARY KEY (id),
    CONSTRAINT book_ledgers_group_fkey FOREIGN KEY (led_group)
        REFERENCES public.book_groups (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT book_ledgers_led_org_fkey FOREIGN KEY (led_org)
        REFERENCES public.book_org (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.book_ledgers
    OWNER to postgres;
	
	
	-- Table: public.book_item_master

-- DROP TABLE public.book_item_master;

CREATE TABLE public.book_item_master
(
    id bigint NOT NULL,
    item_name character varying COLLATE pg_catalog."default",
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    year character varying COLLATE pg_catalog."default",
    opening_quantity integer,
    available_quantity integer,
    price double precision,
    sale_price double precision,
    location character varying COLLATE pg_catalog."default",
    description character varying COLLATE pg_catalog."default",
    active character varying(5) COLLATE pg_catalog."default",
    item_org bigint,
    CONSTRAINT book_item_master_pkey PRIMARY KEY (id),
    CONSTRAINT book_item_master_item_org_fkey FOREIGN KEY (item_org)
        REFERENCES public.book_org (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.book_item_master
    OWNER to postgres;
	
	
	-- Table: public.book_orders

-- DROP TABLE public.book_orders;

CREATE TABLE public.book_orders
(
    id bigint NOT NULL,
    invoice_no integer,
    invoice_date timestamp without time zone,
    vendor bigint,
    approve character varying(5) COLLATE pg_catalog."default",
    order_type character varying(10) COLLATE pg_catalog."default",
    transaction_charges double precision,
    active character varying(5) COLLATE pg_catalog."default",
    order_org bigint,
    grn_no bigint,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    order_amount double precision,
    CONSTRAINT book_orders_pkey PRIMARY KEY (id),
    CONSTRAINT book_orders_order_org_fkey FOREIGN KEY (order_org)
        REFERENCES public.book_org (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT book_orders_vendor_fkey FOREIGN KEY (vendor)
        REFERENCES public.book_ledgers (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.book_orders
    OWNER to postgres;
	
	
	-- Table: public.book_order_items

-- DROP TABLE public.book_order_items;

CREATE TABLE public.book_order_items
(
    id bigint NOT NULL,
    res_no bigint,
    item_no bigint,
    quantity integer,
    cost double precision,
    rejected_quantity integer,
    rejected_reason character varying COLLATE pg_catalog."default",
    amount double precision,
    igst double precision,
    sgst double precision,
    cgst double precision,
    total_amount double precision,
    type character varying COLLATE pg_catalog."default",
    active character varying(5) COLLATE pg_catalog."default",
    order_item_org bigint,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    purchase_price double precision,
    CONSTRAINT book_order_items_pkey PRIMARY KEY (id),
    CONSTRAINT book_order_items_item_no_fkey FOREIGN KEY (item_no)
        REFERENCES public.book_item_master (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT book_order_items_order_item_ord_fkey FOREIGN KEY (order_item_org)
        REFERENCES public.book_org (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT book_order_items_res_no_fkey FOREIGN KEY (res_no)
        REFERENCES public.book_orders (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.book_order_items
    OWNER to postgres;
	
	
	-- Table: public.book_voucher

-- DROP TABLE public.book_voucher;

CREATE TABLE public.book_voucher
(
    id bigint NOT NULL,
    v_group bigint,
    sender bigint,
    receiver bigint,
    amount double precision,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    description character varying COLLATE pg_catalog."default",
    v_type character varying(15) COLLATE pg_catalog."default",
    v_mode character varying(15) COLLATE pg_catalog."default",
    j_ledger character varying COLLATE pg_catalog."default",
    res_no bigint,
    cheque character varying COLLATE pg_catalog."default",
    v_amount double precision,
    active character varying(5) COLLATE pg_catalog."default",
    voucher_org bigint,
    voucher_id bigint,
    voucher_date timestamp without time zone,
    CONSTRAINT book_voucher_pkey PRIMARY KEY (id),
    CONSTRAINT book_voucher_group_fkey FOREIGN KEY (v_group)
        REFERENCES public.book_groups (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT book_voucher_receiver_fkey FOREIGN KEY (receiver)
        REFERENCES public.book_ledgers (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT book_voucher_sender_fkey FOREIGN KEY (sender)
        REFERENCES public.book_ledgers (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT book_voucher_voucher_org_fkey FOREIGN KEY (voucher_org)
        REFERENCES public.book_org (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.book_voucher
    OWNER to postgres;
	


CREATE FUNCTION public.opening_balance()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
opening numeric(10,2);
opening_b numeric(10,2);
BEGIN
IF (TG_OP = 'UPDATE') THEN
	select bo.opening_balance into opening_b from 
		BOOK_OPENING_BALANCE_TRACK bo where bo.ledger_id = new.id;
   IF NEW.opening_balance <> OLD.opening_balance THEN
   		if(new.opening_balance > old.opening_balance) then
			opening = new.opening_balance - old.opening_balance;
		UPDATE BOOK_OPENING_BALANCE_TRACK SET OPENING_BALANCE = OLD.OPENING_BALANCE + opening
		WHERE LEDGER_ID = NEW.ID;	
		end if;
		if(new.opening_balance < old.opening_balance) then 
		opening = old.opening_balance - new.opening_balance;
		UPDATE BOOK_OPENING_BALANCE_TRACK SET OPENING_BALANCE = OLD.OPENING_BALANCE - opening
		WHERE LEDGER_ID = NEW.ID;
		end if; 		
		END IF; 
END IF;

IF (TG_OP = 'INSERT') THEN
	INSERT INTO BOOK_OPENING_BALANCE_TRACK(id,ledger_id,opening_balance,created_date) 
	values (nextval('hibernate_sequence'), new.id,new.opening_balance,current_date);
END IF;
   RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.opening_balance()
    OWNER TO postgres;
	
CREATE TRIGGER opening_balance_changes
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.book_ledgers
    FOR EACH ROW
    EXECUTE PROCEDURE public.opening_balance();
	
	
	ALTER TABLE public.book_item_master
    ALTER COLUMN opening_quantity SET DEFAULT 0;

ALTER TABLE public.book_item_master
    ALTER COLUMN opening_quantity SET NOT NULL;

ALTER TABLE public.book_item_master
    ALTER COLUMN available_quantity SET DEFAULT 0;

ALTER TABLE public.book_item_master
    ALTER COLUMN available_quantity SET NOT NULL;
	

