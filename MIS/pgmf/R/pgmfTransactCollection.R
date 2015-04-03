#CREATE TABLE public.tbltransact_collection_branchwise
#(
#  transactid integer NOT NULL DEFAULT nextval('tbltransact_collection_branchwise_transactid_seq'::regclass),
#  openingprincipal_amt double precision NOT NULL DEFAULT 0,
#  increaseprincipal_amt double precision NOT NULL DEFAULT 0,
#  decreaseprincipal_amt double precision NOT NULL DEFAULT 0,
#  closingprincipal_amt double precision NOT NULL DEFAULT 0,
#  openinginterest_amt double precision NOT NULL DEFAULT 0,
#  increaseinterest_amt double precision NOT NULL DEFAULT 0,
#  decreaseinterest_amt double precision NOT NULL DEFAULT 0,
#  closinginterest_amt double precision NOT NULL DEFAULT 0,
#  reporting_date date,
#  pro_id_fk integer NOT NULL,
#  insert_date timestamp without time zone,
#  CONSTRAINT tbltransact_collection_branchwise_pkey PRIMARY KEY (transactid),
#  CONSTRAINT tbltransact_collection_branchwise_pro_id_fk_fkey FOREIGN KEY (pro_id_fk)
#      REFERENCES public.tblproject (pro_id) MATCH SIMPLE
#      ON UPDATE NO ACTION ON DELETE NO ACTION
#)
#WITH (
#  OIDS=FALSE
#);

pgmf.transact.collection <- function(name, param) {
   stmt <- ""
   err <- ""
   if (name == "pgmf.transact.collection.byid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, openingprincipal_amt, increaseprincipal_amt, decreaseprincipal_amt, closingprincipal_amt, openinginterest_amt, increaseinterest_amt, decreaseinterest_amt, closinginterest_amt, reporting_date, pro_id_fk, insert_date FROM tbltransact_collection_branchwise WHERE transactid='%s';", id)
      err <- paste("ERROR :: Transact Collection is not found for transactID '%s'", id)
   } else   if (name == "pgmf.transact.collection.byreportdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT transactid, openingprincipal_amt, increaseprincipal_amt, decreaseprincipal_amt, closingprincipal_amt, openinginterest_amt, increaseinterest_amt, decreaseinterest_amt, closinginterest_amt, reporting_date, pro_id_fk, insert_date FROM tbltransact_collection_branchwise WHERE reporting_date='%s';", code)
      err <- paste("ERROR :: Transact Collection is not found for Reporting Date '%s'", code)
   } else   if (name == "pgmf.transact.collection.byprojectid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, openingprincipal_amt, increaseprincipal_amt, decreaseprincipal_amt, closingprincipal_amt, openinginterest_amt, increaseinterest_amt, decreaseinterest_amt, closinginterest_amt, reporting_date, pro_id_fk, insert_date FROM tbltransact_collection_branchwise WHERE pro_id_fk='%s';", id)
      err <- paste("ERROR :: Transact Collection is not found for Project ID '%s'", id)
   } else   if (name == "pgmf.transact.collection.byinsertdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT transactid, openingprincipal_amt, increaseprincipal_amt, decreaseprincipal_amt, closingprincipal_amt, openinginterest_amt, increaseinterest_amt, decreaseinterest_amt, closinginterest_amt, reporting_date, pro_id_fk, insert_date FROM tbltransact_collection_branchwise WHERE insert_date='%s';", code)
      err <- paste("ERROR :: Transact Collection is not found for Insert Date '%s'", code)
   } else   if (name == "pgmf.get.transact.collection.csv") {
      stmt <- sprintf("SELECT transactid, openingprincipal_amt, increaseprincipal_amt, decreaseprincipal_amt, closingprincipal_amt, openinginterest_amt, increaseinterest_amt, decreaseinterest_amt, closinginterest_amt, reporting_date, pro_id_fk, insert_date FROM tbltransact_collection_branchwise;")
      err <- paste("ERROR :: Transact Collection is not found")
   }#end of if else nesting

   #rs <- pgmf.get.rows(stmt)
   #if (nrow(rs) == 0) print(err)
   rs <- paste('{"stmt" : "', stmt, '", "err" : "', err, '"}', sep="")
   rs <- fromJSON(rs)
   rs
}#end of pgmf.transact.collection <- function(name, param)

pgmf.set.transact.collection.csv <- function (df) {
   sql <- apply(df, 1, pgmf.transact.collection.format)
   sql
}#end of pgmf.set.transact.collection.csv <- function (df)

pgmf.transact.collection.format <- function(x) {
   transactid <- as.integer(x["transactid"])
   openingprincipal_amt <- as.numeric(x["openingprincipal_amt"])
   increaseprincipal_amt <- as.numeric(x["increaseprincipal_amt"])
   decreaseprincipal_amt <- as.numeric(x["decreaseprincipal_amt"])
   closingprincipal_amt <- as.numeric(x["closingprincipal_amt"])

   openinginterest_amt <- as.numeric(x["openinginterest_amt"])
   increaseinterest_amt <- as.numeric(x["increaseinterest_amt"])
   decreaseinterest_amt <- as.numeric(x["decreaseinterest_amt"])
   closinginterest_amt <- as.numeric(x["closinginterest_amt"])

   reporting_date <- x["reporting_date"]
   pro_id_fk <- as.integer(x["pro_id_fk"])
   insert_date <- x["insert_date"]
   stmt<- sprintf("INSERT INTO tbltransact_collection_branchwise(transactid, openingprincipal_amt, increaseprincipal_amt, decreaseprincipal_amt, closingprincipal_amt, openinginterest_amt, increaseinterest_amt, decreaseinterest_amt, closinginterest_amt, reporting_date, pro_id_fk, insert_date) VALUES (%d, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, '%s', %d, '%s');", transactid, openingprincipal_amt, increaseprincipal_amt, decreaseprincipal_amt, closingprincipal_amt, openinginterest_amt, increaseinterest_amt, decreaseinterest_amt, closinginterest_amt, reporting_date, pro_id_fk, insert_date)
   stmt
}#end of pgmf.transact.collection.format
