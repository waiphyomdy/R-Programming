#CREATE TABLE public.tbltransact_repayment_branchwise
#(
#  transactid integer NOT NULL DEFAULT nextval('tbltransact_repayment_branchwise_transactid_seq'::regclass),
#  collectiontarget_previousmonth double precision NOT NULL DEFAULT 0,
#  totalcollectionwithinterest_previousmonth double precision NOT NULL DEFAULT 0,
#  ontimecollectionwithinterest_previousmonth double precision NOT NULL DEFAULT 0,
#  collectiontarget_thismonth double precision NOT NULL DEFAULT 0,
#  totalcollectionwithinterest_thismonth double precision NOT NULL DEFAULT 0,
#  ontimecollectionwithinterest_thismonth double precision NOT NULL DEFAULT 0,
#  reporting_date date,
#  pro_id_fk integer NOT NULL,
#  insert_date timestamp without time zone,
#  CONSTRAINT tbltransact_repayment_branchwise_pkey PRIMARY KEY (transactid),
#  CONSTRAINT tbltransact_repayment_branchwise_pro_id_fk_fkey FOREIGN KEY (pro_id_fk)
#      REFERENCES public.tblproject (pro_id) MATCH SIMPLE
#      ON UPDATE NO ACTION ON DELETE NO ACTION
#)
#WITH (
#  OIDS=FALSE
#);

pgmf.transact.repayment <- function(name, param) {
   stmt <- ""
   err <- ""
   if (name == "pgmf.transact.repayment.byid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, collectiontarget_previousmonth, totalcollectionwithinterest_previousmonth, ontimecollectionwithinterest_previousmonth, collectiontarget_thismonth, totalcollectionwithinterest_thismonth, ontimecollectionwithinterest_thismonth, reporting_date, pro_id_fk, insert_date FROM tbltransact_repayment_branchwise WHERE transactid='%s';", id)
      err <- paste("ERROR :: Transact Repayment is not found for transactID '%s'", id)
   } else   if (name == "pgmf.transact.repayment.byreportdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT transactid, collectiontarget_previousmonth, totalcollectionwithinterest_previousmonth, ontimecollectionwithinterest_previousmonth, collectiontarget_thismonth, totalcollectionwithinterest_thismonth, ontimecollectionwithinterest_thismonth, reporting_date, pro_id_fk, insert_date FROM tbltransact_repayment_branchwise WHERE reporting_date='%s';", code)
      err <- paste("ERROR :: Transact Repayment is not found for Reporting Date '%s'", code)
   } else   if (name == "pgmf.transact.repayment.byprojectid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, collectiontarget_previousmonth, totalcollectionwithinterest_previousmonth, ontimecollectionwithinterest_previousmonth, collectiontarget_thismonth, totalcollectionwithinterest_thismonth, ontimecollectionwithinterest_thismonth, reporting_date, pro_id_fk, insert_date FROM tbltransact_repayment_branchwise WHERE pro_id_fk='%s';", id)
      err <- paste("ERROR :: Transact Repayment is not found for Project ID '%s'", id)
   } else   if (name == "pgmf.transact.repayment.byinsertdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT transactid, collectiontarget_previousmonth, totalcollectionwithinterest_previousmonth, ontimecollectionwithinterest_previousmonth, collectiontarget_thismonth, totalcollectionwithinterest_thismonth, ontimecollectionwithinterest_thismonth, reporting_date, pro_id_fk, insert_date FROM tbltransact_repayment_branchwise WHERE insert_date='%s';", code)
      err <- paste("ERROR :: Transact Repayment is not found for Insert Date '%s'", code)
   } else   if (name == "pgmf.get.transact.repayment.csv") {
      stmt <- sprintf("SELECT transactid, collectiontarget_previousmonth, totalcollectionwithinterest_previousmonth, ontimecollectionwithinterest_previousmonth, collectiontarget_thismonth, totalcollectionwithinterest_thismonth, ontimecollectionwithinterest_thismonth, reporting_date, pro_id_fk, insert_date FROM tbltransact_repayment_branchwise;")
      err <- paste("ERROR :: Transact Repayment is not found")
   }#end of if else nesting

   #rs <- pgmf.get.rows(stmt)
   #if (nrow(rs) == 0) print(err)
   rs <- paste('{"stmt" : "', stmt, '", "err" : "', err, '"}', sep="")
   rs <- fromJSON(rs)
   rs
}#end of pgmf.transact.repayment <- function(name, param)

pgmf.set.transact.repayment.csv <- function (df) {
   sql <- apply(df, 1, pgmf.transact.repayment.format)
   sql
}#end of pgmf.set.transact.repayment.csv <- function (df)

pgmf.transact.repayment.format <- function(x) {
   transactid <- as.integer(x["transactid"])
   collectiontarget_previousmonth <- as.numeric(x["collectiontarget_previousmonth"])
   totalcollectionwithinterest_previousmonth <- as.numeric(x["totalcollectionwithinterest_previousmonth"])
   ontimecollectionwithinterest_previousmonth <- as.numeric(x["ontimecollectionwithinterest_previousmonth"])
   collectiontarget_thismonth <- as.numeric(x["collectiontarget_thismonth"])

   totalcollectionwithinterest_thismonth <- as.numeric(x["totalcollectionwithinterest_thismonth"])
   ontimecollectionwithinterest_thismonth <- as.numeric(x["ontimecollectionwithinterest_thismonth"])

   reporting_date <- x["reporting_date"]
   pro_id_fk <- as.integer(x["pro_id_fk"])
   insert_date <- x["insert_date"]
   stmt<- sprintf("INSERT INTO tbltransact_repayment_branchwise(transactid, collectiontarget_previousmonth, totalcollectionwithinterest_previousmonth, ontimecollectionwithinterest_previousmonth, collectiontarget_thismonth, totalcollectionwithinterest_thismonth, ontimecollectionwithinterest_thismonth, reporting_date, pro_id_fk, insert_date) VALUES (%d, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, '%s', %d, '%s');", transactid, collectiontarget_previousmonth, totalcollectionwithinterest_previousmonth, ontimecollectionwithinterest_previousmonth, collectiontarget_thismonth, totalcollectionwithinterest_thismonth, ontimecollectionwithinterest_thismonth, reporting_date, pro_id_fk, insert_date)
   stmt
}#end of pgmf.transact.repayment.format
