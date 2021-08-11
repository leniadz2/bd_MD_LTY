SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [bds].[sp_lty_transaccion]
AS
  /***************************************************************************************************
  Procedure:          bds.sp_lty_transaccion
  Create Date:        20210713
  Author:             dÁlvarez
  Description:        carga las tablas de LOYALTY transaccion
  Call by:            bds.sp_lty
  Affected table(s):  bds.LYTY_TRANSACCION
  Used By:            BI
  Parameter(s):       none
  Log:                ctl.CONTROL
  Prerequisites:      none
  ****************************************************************************************************
  SUMMARY OF CHANGES
  Date(YYYYMMDD)      Author              Comments
  ------------------- ------------------- ------------------------------------------------------------
  20210713            dÁlvarez            creación
  20210803            dÁlvarez            actualización
  
  ***************************************************************************************************/

  TRUNCATE TABLE bds.LYTY_TRANSACCION;

  INSERT INTO bds.LYTY_TRANSACCION
  SELECT lc.CODIGOPERSONA,
         lt.NUMTARJETABONUS,
         lc.TIPOTARJETA,
         lc.CODIGOTIPOPERSONA_D,
         lc.TIPODEDOCUMENTO_D,
         lc.NRODOCUMENTO,
         lc.NRORUC,
         lc.DNI_cuentaLyty,
         lt.FECHATRANSACCION_CAB,
         lt.HORATRANSACCION_CAB ,
         lt.HORATRANSSECCION_CAB ,
         lt.CODIGODELOCAL       ,
         lt.CODIGODEPARTICIPANTE,
         lt.NROPOS,
         lt.NROTRNPOS,
         lt.IDTRX,
         lt.SEC,
         lt.PLU                 ,
         lt.CANTIDADNUM         ,
         lt.MONTOPARCIALNUM     ,
         lt.MONTOTOTALNUM
    FROM stg.LYTY_TRANSACCION lt
      LEFT JOIN bds.LYTY_CLI lc 
        ON lt.NUMTARJETABONUS = lc.NUMTARJETABONUS;

GO