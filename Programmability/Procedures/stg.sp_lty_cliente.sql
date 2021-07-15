SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [stg].[sp_lty_cliente]
AS
  /***************************************************************************************************
  Procedure:          stg.sp_lty_cliente
  Create Date:        20210523
  Author:             dÁlvarez
  Description:        carga las tablas de BIBOCL
  Call by:            bds.sp_lty
  Affected table(s):  stg.LYTY_CLI
  Used By:            BI
  Parameter(s):       none
  Log:                ctl.CONTROL
  Prerequisites:      none
  ****************************************************************************************************
  SUMMARY OF CHANGES
  Date(YYYYMMDD)      Author              Comments
  ------------------- ------------------- ------------------------------------------------------------
  20210523            dÁlvarez            creación
  20210713            dÁlvarez            MD_LTY
  
  ***************************************************************************************************/

  TRUNCATE TABLE stg.LYTY_CLI;

  INSERT INTO stg.LYTY_CLI
  SELECT *
    FROM [10.100.150.25].BICLBO.bds.CLIENTES;

GO