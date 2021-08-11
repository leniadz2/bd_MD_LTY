CREATE TABLE [bds].[LYTY_TRANSACCION] (
  [CODIGOPERSONA] [varchar](10) NULL,
  [NUMTARJETABONUS] [varchar](19) NOT NULL,
  [TIPOTARJETA] [varchar](20) NULL,
  [CODIGOTIPOPERSONA_D] [varchar](8) NULL,
  [TIPODEDOCUMENTO_D] [varchar](11) NULL,
  [NRODOCUMENTO] [varchar](15) NULL,
  [NRORUC] [varchar](11) NULL,
  [DNI_cuentaLyty] [int] NULL,
  [FECHATRANSACCION_CAB] [varchar](8) NOT NULL,
  [HORATRANSACCION_CAB] [varchar](8) NOT NULL,
  [HORATRANSSECCION_CAB] [varchar](6) NOT NULL,
  [CODIGODELOCAL] [varchar](4) NOT NULL,
  [CODIGODEPARTICIPANTE] [varchar](4) NOT NULL,
  [NROPOS] [varchar](6) NOT NULL,
  [NROTRNPOS] [varchar](6) NOT NULL,
  [IDTRX] [varchar](18) NOT NULL,
  [SEC] [varchar](3) NOT NULL,
  [PLU] [varchar](14) NOT NULL,
  [CANTIDADNUM] [float] NULL,
  [MONTOPARCIALNUM] [float] NULL,
  [MONTOTOTALNUM] [float] NULL
)
ON [PRIMARY]
GO