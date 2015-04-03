#CREATE TABLE public.tblprojecttsp
#(
#  protspid integer NOT NULL DEFAULT nextval('tblprojecttsp_protspid_seq'::regclass),
#  tblproid_fk smallint NOT NULL DEFAULT (0)::smallint,
#  tbltspid_fk smallint NOT NULL DEFAULT (0)::smallint,
#  CONSTRAINT tblprojecttsp_pkey PRIMARY KEY (protspid),
#  CONSTRAINT tblprojecttsp_tblproid_fk_fkey FOREIGN KEY (tblproid_fk)
#      REFERENCES public.tblproject (pro_id) MATCH SIMPLE
#      ON UPDATE NO ACTION ON DELETE NO ACTION
#)
#WITH (
#  OIDS=FALSE
#);

pgmf.projecttsp <- function(name, param) {
   stmt <- ""
   err <- ""
   if (name == "pgmf.get.projecttsp.byid") {
      id <- param["id"]
      stmt <- sprintf("select protspid, tblproid_fk, tbltspid_fk from tblprojecttsp WHERE protspid='%s';", id)
      err <- paste("ERROR :: Projecttsp is not found for Projecttsp ID ", id)
   } else   if (name == "pgmf.get.projecttsp.byprojectid") {
      id <- param["id"]
      stmt <- sprintf("select protspid, tblproid_fk, tbltspid_fk from tblprojecttsp WHERE tblproid_fk='%s';", id)
      err <- paste("ERROR :: Projecttsp is not found for Project ID ", id)
   } else   if (name == "pgmf.get.projecttsp.bytownshipid") {
      id <- param["id"]
      stmt <- sprintf("select protspid, tblproid_fk, tbltspid_fk from tblprojecttsp WHERE tbltspid_fk='%s';", id)
      err <- paste("ERROR :: Projecttsp is not found for Township ID ", id)
   } else   if (name == "pgmf.get.projecttsp.csv") {
      stmt <- sprintf("select protspid, tblproid_fk, tbltspid_fk from tblprojecttsp;")
      err <- paste("ERROR :: Portfolio is not found")
   }#end of if else nesting

   #rs <- pgmf.get.rows(stmt)
   #if (nrow(rs) == 0) print(err)
   rs <- paste('{"stmt" : "', stmt, '", "err" : "', err, '"}', sep="")
   rs <- fromJSON(rs)
   rs
}#end of pgmf.projecttsp <- function(name, param)

pgmf.set.projecttsp.csv <- function (df) {
   sql <- apply(df, 1, pgmf.projecttsp.format)
   sql
}#end of pgmf.set.projecttsp.csv <- function (df)

pgmf.projecttsp.format <- function(x) {
   protspid <- as.integer(x["protspid"])
   tblproid_fk <- as.integer(x["tblproid_fk"])
   tbltspid_fk <- as.integer(x["tbltspid_fk"])
   stmt<- sprintf("INSERT INTO tblprojecttsp(protspid, tblproid_fk, tbltspid_fk) VALUES (%d, %d, %d);", protspid, tblproid_fk, tbltspid_fk)
   stmt
}#end of pgmf.projecttsp.format
