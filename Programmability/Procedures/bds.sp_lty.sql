SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [bds].[sp_lty]
AS
  /***************************************************************************************************
  Procedure:          stg.sp_lty
  Create Date:        20210713
  Author:             dÁlvarez
  Description:        carga las tablas de LOYALTY
  Call by:            none
  Affected table(s):  stg.LYTY_CLI
                      ods.LYTY_CLI
                      bds.LYTY_CLI
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

  DECLARE @strgFec NVARCHAR(8);
  DECLARE @strgTim NVARCHAR(6);
  DECLARE @strgFT NVARCHAR(14);

  /* tabla control */
  DECLARE @prceso NVARCHAR(50);
  DECLARE @objtnm NVARCHAR(50);
  DECLARE @s_fld1 NVARCHAR(50);
  DECLARE @s_fld2 NVARCHAR(14);
  DECLARE @i_fld1 INT;

  SET DATEFIRST 1;

  SET @strgFec = CONVERT(VARCHAR, GETDATE(), 112);
  SET @strgTim = REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', '');
  
  /*--carga manual de fechas
  SET @strgFec = '20219988';
  SET @strgTim = '242322';
  */
  
  SET @strgFT = CONCAT(@strgFec, @strgTim);

  SET @prceso = 'CARGATABLA';
  SET @objtnm = 'LYTY_CLI';


  /* CLIENTE  ***********************************************************************/
  SET @strgTim = REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', '');

  INSERT INTO ctl.CONTROL(PRCESO, OBJTNM, FECHOR, S_FLD9)
  VALUES(@prceso,@objtnm,@strgFT,@strgTim);

  EXEC stg.sp_lty_cliente;

  SET @strgTim = REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', '');

  UPDATE ctl.CONTROL
    SET S_FLD8 = @strgTim
  WHERE PRCESO = @prceso
    AND OBJTNM = @objtnm
    AND FECHOR = @strgFT;

  EXEC ods.sp_lty_cliente;

  SET @strgTim = REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', '');

  UPDATE ctl.CONTROL
    SET S_FLD7 = @strgTim
  WHERE PRCESO = @prceso
    AND OBJTNM = @objtnm
    AND FECHOR = @strgFT;

  EXEC bds.sp_lty_cliente;

  SET @strgTim = REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', '');

  UPDATE ctl.CONTROL
    SET S_FLD6 = @strgTim
  WHERE PRCESO = @prceso
    AND OBJTNM = @objtnm
    AND FECHOR = @strgFT;

  /* TRANSACCION  *******************************************************************/
  SET @objtnm = 'LYTY_TRANSACCION';
  SET @strgTim = REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', '');
  SET @strgFT = CONCAT(@strgFec, @strgTim);

  INSERT INTO ctl.CONTROL(PRCESO, OBJTNM, FECHOR, S_FLD9)
  VALUES(@prceso,@objtnm,@strgFT,@strgTim);

  EXEC stg.sp_lty_transaccion;

  SET @strgTim = REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', '');

  UPDATE ctl.CONTROL
    SET S_FLD8 = @strgTim
  WHERE PRCESO = @prceso
    AND OBJTNM = @objtnm
    AND FECHOR = @strgFT;

GO