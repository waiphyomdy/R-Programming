#CREATE TABLE public.tblstaff
#(
#  staff_id integer NOT NULL DEFAULT nextval('tblstaff_staff_id_seq'::regclass),
#  staff_indicator character varying(50),
#  CONSTRAINT tblstaff_pkey PRIMARY KEY (staff_id)
#)
#WITH (
#  OIDS=FALSE
#);

pgmf.staff <- function(name, param) {
   stmt <- ""
   err <- ""
   if (name == "pgmf.get.staff.byid") {
      id <- param["id"]
      stmt <- sprintf("select staff_id, staff_indicator from tblstaff WHERE staff_id='%s';", id)
      err <- paste("ERROR :: Staff is not found for Staff ID '%s'", id)
   } else   if (name == "pgmf.get.staff.bycat") {
      code <- param["code"]
      stmt <- sprintf("select staff_id, staff_indicator from tblstaff WHERE staff_indicator='%s';", code)
      err <- paste("ERROR :: Staff is not found for Staff Cat '%s'", code)
   } else   if (name == "pgmf.get.staff.csv") {
      stmt <- sprintf("select staff_id, staff_indicator from tblstaff;")
      err <- paste("ERROR :: Staff is not found")
   }#end of if else nesting

   #rs <- pgmf.get.rows(stmt)
   #if (nrow(rs) == 0) print(err)
   rs <- paste('{"stmt" : "', stmt, '", "err" : "', err, '"}', sep="")
   rs <- fromJSON(rs)
   rs
}#end of pgmf.staff <- function(name, param)

pgmf.set.staff.csv <- function (df) {
   sql <- apply(df, 1, pgmf.staff.format)
   sql
}#end of pgmf.set.staff.csv <- function (df)

pgmf.staff.format <- function(x) {
   staff_id <- as.integer(x["staff_id"])
   staff_indicator <- x["staff_indicator"]
   stmt<- sprintf("INSERT INTO tblstaff(staff_id, staff_indicator) VALUES (%d, '%s');", staff_id, staff_indicator)
   stmt
}#end of pgmf.staff.format
