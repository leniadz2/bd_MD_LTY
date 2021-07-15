SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [bds].[sp_lty_transacion]
AS
  /***************************************************************************************************
  Procedure:          stg.sp_lty_transacion
  Create Date:        20210713
  Author:             dÁlvarez
  Description:        carga las tablas de LOYALTY transaccion
  Call by:            bds.sp_lty
  Affected table(s):  stg.LYTY_TRANSACCION
  Used By:            BI
  Parameter(s):       none
  Log:                ctl.CONTROL
  Prerequisites:      none
  ****************************************************************************************************
  SUMMARY OF CHANGES
  Date(YYYYMMDD)      Author              Comments
  ------------------- ------------------- ------------------------------------------------------------
  20210713            dÁlvarez            creación
  
  ***************************************************************************************************/

  TRUNCATE TABLE stg.LYTY_TRANSACCION;

  INSERT INTO stg.LYTY_TRANSACCION
  SELECT *
    FROM [10.100.150.25].BICLBO.bds.TRANSACCION;

GO