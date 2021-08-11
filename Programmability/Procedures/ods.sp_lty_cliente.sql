SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [ods].[sp_lty_cliente]
AS
  /***************************************************************************************************
  Procedure:          ods.sp_lty_cliente
  Create Date:        20210521
  Author:             dÁlvarez
  Description:        carga el maestro de clientes BONUS con las siguientes condiciones:
                       - Solo los que tienen la tarjeta BONUS más antigua
                       - Solo los que tienen número DNI válido.
                      Además crea un campo contador de DNI (muestra errores (mayores a uno))
  Call by:            bds.sp_lty
  Affected table(s):  ods.LYTY_CLI
                      ods.LYTY_CLI_tmp1/tmp2/tmp3/tmp4
  Used By:            BI
  Parameter(s):       none
  Log:                ctl.CONTROL
  Prerequisites:      stg.sp_lty_cliente
  ****************************************************************************************************
  SUMMARY OF CHANGES
  Date(YYYYMMDD)      Author              Comments
  ------------------- ------------------- ------------------------------------------------------------
  20210521            dÁlvarez            creación
  20210601            dÁlvarez            simplificacion lógica
  20210610            dÁlvarez            registros proveidos externamente
  20210713            dÁlvarez            MD_LTY
  20210810            dÁlvarez            WA DNI_cuentaLyty <> 1
  
  ***************************************************************************************************/

TRUNCATE TABLE ods.LYTY_CLI_tmp1;

INSERT INTO ods.LYTY_CLI_tmp1
SELECT lc.CODIGOPERSONA
      ,lc.ORDTARJETABONUS
      ,lc.NUMTARJETABONUS
      ,lc.TIPOTARJETA                  
      ,lc.CODIGOTIPOPERSONA            
      ,lc.CODIGOTIPOPERSONA_D          
      ,lc.TIPODEDOCUMENTO              
      ,lc.TIPODEDOCUMENTO_D            
      ,lc.NRODOCUMENTO                 
      ,lc.NRORUC
      ,ods.fn_validaDNI(lc.NRODOCUMENTO) AS DNI_Valido
      ,lc.NOMBRES                      
      ,lc.APELLIDOPATERNO              
      ,lc.APELLIDOMATERNO              
      ,lc.FECHANACIMIENTO              
      ,lc.EDAD                         
      ,lc.EDAD_RANGO                   
      ,lc.SEXO_TIT                     
      ,lc.SEXO_TIT_D                   
      ,lc.FLAGESTADOCIVIL              
      ,lc.FLAGESTADOCIVIL_D            
      ,lc.FLAGTIENEHIJOS               
      ,lc.FLAGTIENEHIJOS_D             
      ,lc.FLAGTIENETELEFONO            
      ,lc.FLAGTIENETELEFONO_D          
      ,lc.FLAGTIENECORREO              
      ,lc.FLAGTIENECORREO_D            
      ,lc.FLAGCOMPARTEDATOS            
      ,lc.FLAGCOMPARTEDATOS_D          
      ,lc.FLAGAUTCANJE                 
      ,lc.FLAGAUTCANJE_D               
      ,lc.FLAGCLTEFALLECIDO            
      ,lc.FLAGCLTEFALLECIDO_D          
      ,lc.RAZONSOCIAL                  
      ,lc.FECHACREACION_PER            
      ,lc.HORACREACION_PER             
      ,lc.FECHAULTMODIF_PER            
      ,lc.FECHACARGAINICIAL_PER        
      ,lc.FECHACARGAULTMODIF_PER       
      ,lc.CODPOS                       
      ,lc.DIRECCION                    
      ,lc.DEPARTAMENTO                 
      ,lc.PROVINCIA                    
      ,lc.DISTRITO                     
      ,lc.FLAGULTIMO_DIR               
      ,lc.REFERENCIA                   
      ,lc.ESTADO                       
      ,lc.ESTADO_D                     
      ,lc.COORDENADAX                  
      ,lc.COORDENADAY                  
      ,lc.FLAGCOORDENADA               
      ,lc.NSE                          
      ,lc.TELEFONO                     
      ,lc.TELEFONO_D                   
      ,lc.FECHACREACION_TEL            
      ,lc.EMAIL                        
      ,lc.FECHACREACION_EML            
      ,lc.HIJ_AS                       
      ,lc.HIJ_OS                       
      ,lc.HIJ_NN                       
      ,lc.HIJ_TOT
  FROM stg.LYTY_CLI lc
 WHERE lc.ORDTARJETABONUS = 1;

TRUNCATE TABLE ods.LYTY_CLI_tmp2;

INSERT INTO ods.LYTY_CLI_tmp2
  (CODIGOPERSONA,
   CODIGOTIPOPERSONA,
   CODIGOTIPOPERSONA_D,
   TIPODEDOCUMENTO,
   TIPODEDOCUMENTO_D,
   NRODOCUMENTO,
   DNI_Valido,
   NOMBRES,
   APELLIDOPATERNO,
   APELLIDOMATERNO,
   FECHANACIMIENTO,
   EDAD,
   EDAD_RANGO,
   SEXO_TIT,
   SEXO_TIT_D,
   FLAGESTADOCIVIL,
   FLAGESTADOCIVIL_D,
   ORDTARJETABONUS,
   NUMTARJETABONUS
)
SELECT '9999999999'
      ,'01'
      ,'Natural'
      ,'0001'
      ,'DNI'
      ,NRODOCUMENTO
      ,ods.fn_validaDNI(NRODOCUMENTO) AS DNI_Valido
      ,NOMBRES
      ,APELLIDOPATERNO
      ,APELLIDOMATERNO
      ,FECHANACIMIENTO
      ,DATEDIFF(YY, CONVERT(DATETIME, FECHANACIMIENTO), GETDATE()) -
       CASE 
            WHEN DATEADD(YY,DATEDIFF(YY, CONVERT(DATETIME, FECHANACIMIENTO), GETDATE()),CONVERT(DATETIME, FECHANACIMIENTO)) > GETDATE() THEN 1
            ELSE 0
       END AS EDAD
      ,CASE
           WHEN (2020 - LEFT(FECHANACIMIENTO,4)) < 18 THEN 'MENOR DE EDAD'
           WHEN (2020 - LEFT(FECHANACIMIENTO,4)) >= 18 AND (2020 - LEFT(FECHANACIMIENTO,4)) < 20 THEN '18-19'
           WHEN (2020 - LEFT(FECHANACIMIENTO,4)) >= 20 AND (2020 - LEFT(FECHANACIMIENTO,4)) < 30 THEN '20-29'
           WHEN (2020 - LEFT(FECHANACIMIENTO,4)) >= 30 AND (2020 - LEFT(FECHANACIMIENTO,4)) < 40 THEN '30-39'
           WHEN (2020 - LEFT(FECHANACIMIENTO,4)) >= 40 AND (2020 - LEFT(FECHANACIMIENTO,4)) < 50 THEN '40-49'
           WHEN (2020 - LEFT(FECHANACIMIENTO,4)) >= 50 AND (2020 - LEFT(FECHANACIMIENTO,4)) < 60 THEN '50-59'
           WHEN (2020 - LEFT(FECHANACIMIENTO,4)) >= 60 AND (2020 - LEFT(FECHANACIMIENTO,4)) < 70 THEN '60-69'
           WHEN (2020 - LEFT(FECHANACIMIENTO,4)) >= 70 AND (2020 - LEFT(FECHANACIMIENTO,4)) < 80 THEN '70-79'
           ELSE 'MAYORES DE 80'
       END as  EDAD_RANGO
      ,CASE
         WHEN SEXO = 'F' THEN '1'
         WHEN SEXO = 'M' THEN '2'
         WHEN SEXO IS NULL THEN NULL
         ELSE '9'
       END AS SEXO_TIT
      ,CASE
         WHEN SEXO = 'F' THEN 'FEMENINO'
         WHEN SEXO = 'M' THEN 'MASCULINO'
         WHEN SEXO IS NULL THEN NULL
         ELSE 'ZZ'
       END AS SEXO_TIT_D
      ,CASE
         WHEN ESTADOCIVIL = 'S' THEN '1'
         WHEN ESTADOCIVIL = 'C' THEN '2'
         WHEN ESTADOCIVIL = 'V' THEN '3'
         WHEN ESTADOCIVIL = 'D' THEN '4'
         WHEN ESTADOCIVIL IS NULL THEN NULL
         ELSE '9'
       END AS FLAGESTADOCIVIL
      ,CASE
         WHEN ESTADOCIVIL = 'S' THEN 'SOLTERO'
         WHEN ESTADOCIVIL = 'C' THEN 'CASADO'
         WHEN ESTADOCIVIL = 'V' THEN 'VIUDO'
         WHEN ESTADOCIVIL = 'D' THEN 'DIVORCIADO'
         WHEN ESTADOCIVIL IS NULL THEN 'Sin definir'
         ELSE 'ZZZZZZZZZZZ'
       END AS FLAGESTADOCIVIL_D
      ,1
      ,NUMTARJETABONUS
  FROM tmp.LYTY_CLI_cargaPlano
 WHERE NRODOCUMENTO NOT IN (SELECT NRODOCUMENTO FROM ods.LYTY_CLI_tmp1);

TRUNCATE TABLE ods.LYTY_CLI_tmp3;

INSERT INTO ods.LYTY_CLI_tmp3
SELECT * FROM ods.LYTY_CLI_tmp1
 UNION ALL
SELECT * FROM ods.LYTY_CLI_tmp2;

TRUNCATE TABLE ods.LYTY_CLI_tmp4;

INSERT INTO ods.LYTY_CLI_tmp4
SELECT lc.NRODOCUMENTO                 
      ,COUNT(NRODOCUMENTO) AS DNI_cuentaLyty
  FROM ods.LYTY_CLI_tmp3 lc
 WHERE lc.DNI_Valido = '1'
 GROUP BY lc.NRODOCUMENTO;

TRUNCATE TABLE ods.LYTY_CLI;

INSERT INTO ods.LYTY_CLI
SELECT lc.CODIGOPERSONA
      ,lc.ORDTARJETABONUS
      ,lc.NUMTARJETABONUS
      ,lc.TIPOTARJETA                  
      ,lc.CODIGOTIPOPERSONA            
      ,lc.CODIGOTIPOPERSONA_D          
      ,lc.TIPODEDOCUMENTO              
      ,lc.TIPODEDOCUMENTO_D            
      ,lc.NRODOCUMENTO                 
      ,lc.NRORUC
      ,ld.DNI_cuentaLyty
      ,lc.NOMBRES                      
      ,lc.APELLIDOPATERNO              
      ,lc.APELLIDOMATERNO              
      ,lc.FECHANACIMIENTO              
      ,lc.EDAD                         
      ,lc.EDAD_RANGO                   
      ,lc.SEXO_TIT                     
      ,lc.SEXO_TIT_D                   
      ,lc.FLAGESTADOCIVIL              
      ,lc.FLAGESTADOCIVIL_D            
      ,lc.FLAGTIENEHIJOS               
      ,lc.FLAGTIENEHIJOS_D             
      ,lc.FLAGTIENETELEFONO            
      ,lc.FLAGTIENETELEFONO_D          
      ,lc.FLAGTIENECORREO              
      ,lc.FLAGTIENECORREO_D            
      ,lc.FLAGCOMPARTEDATOS            
      ,lc.FLAGCOMPARTEDATOS_D          
      ,lc.FLAGAUTCANJE                 
      ,lc.FLAGAUTCANJE_D               
      ,lc.FLAGCLTEFALLECIDO            
      ,lc.FLAGCLTEFALLECIDO_D          
      ,lc.RAZONSOCIAL                  
      ,lc.FECHACREACION_PER            
      ,lc.HORACREACION_PER             
      ,lc.FECHAULTMODIF_PER            
      ,lc.FECHACARGAINICIAL_PER        
      ,lc.FECHACARGAULTMODIF_PER       
      ,lc.CODPOS                       
      ,lc.DIRECCION                    
      ,lc.DEPARTAMENTO                 
      ,lc.PROVINCIA                    
      ,lc.DISTRITO                     
      ,lc.FLAGULTIMO_DIR               
      ,lc.REFERENCIA                   
      ,lc.ESTADO                       
      ,lc.ESTADO_D                     
      ,lc.COORDENADAX                  
      ,lc.COORDENADAY                  
      ,lc.FLAGCOORDENADA               
      ,lc.NSE                          
      ,lc.TELEFONO                     
      ,lc.TELEFONO_D                   
      ,lc.FECHACREACION_TEL            
      ,lc.EMAIL                        
      ,lc.FECHACREACION_EML            
      ,lc.HIJ_AS                       
      ,lc.HIJ_OS                       
      ,lc.HIJ_NN                       
      ,lc.HIJ_TOT
  FROM ods.LYTY_CLI_tmp3 lc LEFT JOIN ods.LYTY_CLI_tmp4 ld 
       ON lc.NRODOCUMENTO = ld.NRODOCUMENTO
 WHERE lc.DNI_Valido = 1
   AND ld.DNI_cuentaLyty = 1;

--WA DNI_cuentaLyty <> 1
INSERT INTO ods.LYTY_CLI
SELECT lc.CODIGOPERSONA
      ,lc.ORDTARJETABONUS
      ,lc.NUMTARJETABONUS
      ,lc.TIPOTARJETA                  
      ,lc.CODIGOTIPOPERSONA            
      ,lc.CODIGOTIPOPERSONA_D          
      ,lc.TIPODEDOCUMENTO              
      ,lc.TIPODEDOCUMENTO_D            
      ,lc.NRODOCUMENTO                 
      ,lc.NRORUC
      ,ld.DNI_cuentaLyty
      ,lc.NOMBRES                      
      ,lc.APELLIDOPATERNO              
      ,lc.APELLIDOMATERNO              
      ,lc.FECHANACIMIENTO              
      ,lc.EDAD                         
      ,lc.EDAD_RANGO                   
      ,lc.SEXO_TIT                     
      ,lc.SEXO_TIT_D                   
      ,lc.FLAGESTADOCIVIL              
      ,lc.FLAGESTADOCIVIL_D            
      ,lc.FLAGTIENEHIJOS               
      ,lc.FLAGTIENEHIJOS_D             
      ,lc.FLAGTIENETELEFONO            
      ,lc.FLAGTIENETELEFONO_D          
      ,lc.FLAGTIENECORREO              
      ,lc.FLAGTIENECORREO_D            
      ,lc.FLAGCOMPARTEDATOS            
      ,lc.FLAGCOMPARTEDATOS_D          
      ,lc.FLAGAUTCANJE                 
      ,lc.FLAGAUTCANJE_D               
      ,lc.FLAGCLTEFALLECIDO            
      ,lc.FLAGCLTEFALLECIDO_D          
      ,lc.RAZONSOCIAL                  
      ,lc.FECHACREACION_PER            
      ,lc.HORACREACION_PER             
      ,lc.FECHAULTMODIF_PER            
      ,lc.FECHACARGAINICIAL_PER        
      ,lc.FECHACARGAULTMODIF_PER       
      ,lc.CODPOS                       
      ,lc.DIRECCION                    
      ,lc.DEPARTAMENTO                 
      ,lc.PROVINCIA                    
      ,lc.DISTRITO                     
      ,lc.FLAGULTIMO_DIR               
      ,lc.REFERENCIA                   
      ,lc.ESTADO                       
      ,lc.ESTADO_D                     
      ,lc.COORDENADAX                  
      ,lc.COORDENADAY                  
      ,lc.FLAGCOORDENADA               
      ,lc.NSE                          
      ,lc.TELEFONO                     
      ,lc.TELEFONO_D                   
      ,lc.FECHACREACION_TEL            
      ,lc.EMAIL                        
      ,lc.FECHACREACION_EML            
      ,lc.HIJ_AS                       
      ,lc.HIJ_OS                       
      ,lc.HIJ_NN                       
      ,lc.HIJ_TOT
  FROM ods.LYTY_CLI_tmp3 lc LEFT JOIN ods.LYTY_CLI_tmp4 ld 
       ON lc.NRODOCUMENTO = ld.NRODOCUMENTO
 WHERE lc.DNI_Valido = 1
   AND ld.DNI_cuentaLyty <> 1
   AND lc.TIPODEDOCUMENTO = '0001';

GO