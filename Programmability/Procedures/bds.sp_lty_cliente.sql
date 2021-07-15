SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [bds].[sp_lty_cliente]
AS
  /***************************************************************************************************
  Procedure:          bds.[sp_lty_cliente]
  Create Date:        20210601
  Author:             dÁlvarez
  Description:        carga en bds el cliente Bonus
  Call by:            bds.sp_lty
  Affected table(s):  bds.LYTY_CLI
  Used By:            BI
  Parameter(s):       none
  Log:                ctl.CONTROL
  Prerequisites:      ods.sp_lty_cliente
  ****************************************************************************************************
  SUMMARY OF CHANGES
  Date(YYYYMMDD)      Author              Comments
  ------------------- ------------------- ------------------------------------------------------------
  20210601            dÁlvarez            creación
  20210713            dÁlvarez            MD_LTY
  
  ***************************************************************************************************/

TRUNCATE TABLE bds.LYTY_CLI;

DROP INDEX bds.LYTY_CLI.IX1_LYTY_CLI;

INSERT INTO bds.LYTY_CLI
SELECT CODIGOPERSONA
      ,ORDTARJETABONUS
      ,NUMTARJETABONUS
      ,TIPOTARJETA
      ,CODIGOTIPOPERSONA
      ,CODIGOTIPOPERSONA_D
      ,TIPODEDOCUMENTO
      ,TIPODEDOCUMENTO_D
      ,NRODOCUMENTO
      ,NRORUC
      ,DNI_cuentaLyty
      ,NOMBRES
      ,APELLIDOPATERNO
      ,APELLIDOMATERNO
      ,FECHANACIMIENTO
      ,EDAD
      ,EDAD_RANGO
      ,SEXO_TIT
      ,SEXO_TIT_D
      ,CASE 
            WHEN FLAGESTADOCIVIL = 'X' THEN NULL
            ELSE FLAGESTADOCIVIL
       END AS FLAGESTADOCIVIL
      ,CASE 
            WHEN FLAGESTADOCIVIL IS NULL THEN NULL
            WHEN FLAGESTADOCIVIL = 'X' THEN NULL
            ELSE FLAGESTADOCIVIL_D
       END AS FLAGESTADOCIVIL_D
      ,FLAGTIENEHIJOS
      ,FLAGTIENEHIJOS_D
      ,FLAGTIENETELEFONO
      ,FLAGTIENETELEFONO_D
      ,FLAGTIENECORREO
      ,FLAGTIENECORREO_D
      ,FLAGCOMPARTEDATOS
      ,FLAGCOMPARTEDATOS_D
      ,FLAGAUTCANJE
      ,FLAGAUTCANJE_D
      ,FLAGCLTEFALLECIDO
      ,FLAGCLTEFALLECIDO_D
      ,RAZONSOCIAL
      ,FECHACREACION_PER
      ,HORACREACION_PER
      ,FECHAULTMODIF_PER
      ,FECHACARGAINICIAL_PER
      ,FECHACARGAULTMODIF_PER
      ,CODPOS
      ,DIRECCION
      ,DEPARTAMENTO
      ,PROVINCIA
      ,DISTRITO
      ,FLAGULTIMO_DIR
      ,REFERENCIA
      ,ESTADO
      ,ESTADO_D
      ,COORDENADAX
      ,COORDENADAY
      ,FLAGCOORDENADA
      ,NSE
      ,TELEFONO
      ,TELEFONO_D
      ,FECHACREACION_TEL
      ,EMAIL
      ,FECHACREACION_EML
      ,HIJ_AS
      ,HIJ_OS
      ,HIJ_NN
      ,HIJ_TOT
  FROM ods.LYTY_CLI;

CREATE INDEX IX1_LYTY_CLI
ON bds.LYTY_CLI(NRODOCUMENTO);

GO