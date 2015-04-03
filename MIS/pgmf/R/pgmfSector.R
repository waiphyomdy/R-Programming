#CREATE TABLE public.tblsector
#(
#  sectorid integer NOT NULL DEFAULT nextval('tblsector_sectorid_seq'::regclass),
#  sector character varying(50) DEFAULT NULL::character varying,
#  CONSTRAINT tblsector_pkey PRIMARY KEY (sectorid)
#)
#WITH (
#  OIDS=FALSE
#);

pgmf.sector <- function(name, param) {
   stmt <- ""
   err <- ""
   if (name == "pgmf.get.sector.byid") {
      id <- param["id"]
      stmt <- sprintf("select sectorid, sector from tblsector WHERE sectorid='%s';", id)
      err <- paste("ERROR :: Sector is not found for Sector ID ", id)
   } else   if (name == "pgmf.get.sector.bysector") {
      code <- param["code"]
      stmt <- sprintf("select sectorid, sector from tblsector WHERE sector='%s';", code)
      err <- paste("ERROR :: Sector is not found for Sector '%s'", code)
   } else   if (name == "pgmf.get.sector.csv") {
      stmt <- sprintf("select sectorid, sector from tblsector order by sectorid;")
      err <- paste("ERROR :: Sector is not found")
   }#end of if else nesting

   #rs <- pgmf.get.rows(stmt)
   #if (nrow(rs) == 0) print(err)
   rs <- paste('{"stmt" : "', stmt, '", "err" : "', err, '"}', sep="")
   rs <- fromJSON(rs)
   rs
}#end of pgmf.sector <- function(name, param)

pgmf.set.sector.csv <- function (df) {
   sql <- apply(df, 1, pgmf.sector.format)
   sql
}#end of pgmf.set.sector.csv <- function (df)

pgmf.sector.format <- function(x) {
   sectorid <- as.integer(x["sectorid"])
   sector <- x["sector"]
   stmt<- sprintf("INSERT INTO tblsector(sectorid, sector) VALUES (%d, '%s');", sectorid, sector)
   stmt
}#end of pgmf.sector.format

