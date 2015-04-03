#CREATE TABLE public.tbltransact_staff_branchwise
#(
#  staff_id integer NOT NULL DEFAULT nextval('tbltransact_staff_branchwise_staff_id_seq'::regclass),
#  opening_num integer NOT NULL DEFAULT 0,
#  increase_num integer NOT NULL DEFAULT 0,
#  decrease_num integer NOT NULL DEFAULT 0,
#  closing_num integer NOT NULL DEFAULT 0,
#  reporting_date date,
#  staff_id_fk integer NOT NULL,
#  pro_id_fk integer NOT NULL,
#  insert_date timestamp without time zone,
#  CONSTRAINT tbltransact_staff_branchwise_pkey PRIMARY KEY (staff_id),
#  CONSTRAINT tbltransact_staff_branchwise_pro_id_fk_fkey FOREIGN KEY (pro_id_fk)
#      REFERENCES public.tblproject (pro_id) MATCH SIMPLE
#      ON UPDATE NO ACTION ON DELETE NO ACTION,
#  CONSTRAINT tbltransact_staff_branchwise_staff_id_fk_fkey FOREIGN KEY (staff_id_fk)
#      REFERENCES public.tblstaff (staff_id) MATCH SIMPLE
#      ON UPDATE NO ACTION ON DELETE NO ACTION
#)
#WITH (
#  OIDS=FALSE
#);

pgmf.transact.staff <- function(name, param) {
   stmt <- ""
   err <- ""
   if (name == "pgmf.transact.staff.byid") {
      id <- param["id"]
      stmt <- sprintf("SELECT staff_id, opening_num, increase_num, decrease_num, closing_num, reporting_date, staff_id_fk, pro_id_fk, insert_date FROM tbltransact_staff_branchwise WHERE staff_id='%s';", id)
      err <- paste("ERROR :: Transact Staff is not found for transactStaffID '%s'", id)
   } else   if (name == "pgmf.transact.staff.byreportdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT staff_id, opening_num, increase_num, decrease_num, closing_num, reporting_date, staff_id_fk, pro_id_fk, insert_date FROM tbltransact_staff_branchwise WHERE reporting_date='%s';", code)
      err <- paste("ERROR :: Transact Staff is not found for Reporting Date '%s'", code)
   } else   if (name == "pgmf.transact.staff.bystaffid") {
      id <- param["id"]
      stmt <- sprintf("SELECT staff_id, opening_num, increase_num, decrease_num, closing_num, reporting_date, staff_id_fk, pro_id_fk, insert_date FROM tbltransact_staff_branchwise WHERE staff_id_fk='%s';", id)
      err <- paste("ERROR :: Transact Staff is not found for Staff ID '%s'", id)
   } else   if (name == "pgmf.transact.staff.byprojectid") {
      id <- param["id"]
      stmt <- sprintf("SELECT staff_id, opening_num, increase_num, decrease_num, closing_num, reporting_date, staff_id_fk, pro_id_fk, insert_date FROM tbltransact_staff_branchwise WHERE pro_id_fk='%s';", id)
      err <- paste("ERROR :: Transact Staff is not found for Project ID '%s'", id)
   } else   if (name == "pgmf.transact.staff.byinsertdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT staff_id, opening_num, increase_num, decrease_num, closing_num, reporting_date, staff_id_fk, pro_id_fk, insert_date FROM tbltransact_staff_branchwise WHERE insert_date='%s';", code)
      err <- paste("ERROR :: Transact Staff is not found for Insert Date '%s'", code)
   } else   if (name == "pgmf.get.transact.staff.csv") {
      stmt <- sprintf("SELECT staff_id, opening_num, increase_num, decrease_num, closing_num, reporting_date, staff_id_fk, pro_id_fk, insert_date FROM tbltransact_staff_branchwise;")
      err <- paste("ERROR :: Transact Staff is not found")
   }#end of if else nesting

   #rs <- pgmf.get.rows(stmt)
   #if (nrow(rs) == 0) print(err)
   rs <- paste('{"stmt" : "', stmt, '", "err" : "', err, '"}', sep="")
   rs <- fromJSON(rs)
   rs
}#end of pgmf.transact.saving <- function(name, param)

pgmf.set.transact.staff.csv <- function (df) {
   sql <- apply(df, 1, pgmf.transact.staff.format)
   sql
}#end of pgmf.set.transact.staff.csv <- function (df)

pgmf.transact.staff.format <- function(x) {
   staff_id <- as.integer(x["staff_id"])
   opening_num <- as.integer(x["opening_num"])
   increase_num <- as.integer(x["increase_num"])
   decrease_num <- as.integer(x["decrease_num"])
   closing_num <- as.integer(x["closing_num"])

   reporting_date <- x["reporting_date"]
   staff_id_fk <- as.integer(x["staff_id_fk"])
   pro_id_fk <- as.integer(x["pro_id_fk"])
   insert_date <- x["insert_date"]
   stmt<- sprintf("INSERT INTO tbltransact_staff_branchwise(staff_id, opening_num, increase_num, decrease_num, closing_num, reporting_date, staff_id_fk, pro_id_fk, insert_date) VALUES (%d, %d, %d, %d, %d, '%s', %d, %d, '%s');", staff_id, opening_num, increase_num, decrease_num, closing_num, reporting_date, staff_id_fk, pro_id_fk, insert_date)
   stmt
}#end of pgmf.transact.staff.format
