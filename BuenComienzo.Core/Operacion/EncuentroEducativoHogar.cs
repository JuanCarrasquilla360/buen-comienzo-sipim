using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;
using BuenComienzo.Core.Administracion.To;

namespace BuenComienzo.Core.Operacion
{
    public class EncuentroEducativoHogar
    {

        private string strError;
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public string Error
        {
            get
            {
                return strError;
            }
        }

        public DataTable ConsultarEncuentroEducativoHogar(string idCoordinador, string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_ENCUENTROEDUCATIVOHOGAR", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public string InsertarEncuentroEducativoHogar(string numeroIdentificacion, DateTime fechaHora, string idTipoEEH, string EEHNumero, string idMotivoEEH, string EEHEfectivo, 
                                        string idMotivoNoEfectivo, string observaciones, string idMatricula, string idCoordinador, string idUsuarioCreacion)
        {
            try
            {
                Object resp;
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaHora", Valor = fechaHora, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdTipoEEH", Valor = idTipoEEH, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@EEHNumero", Valor = EEHNumero, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdMotivoEEH", Valor = idMotivoEEH, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@EEHEfectivo", Valor = EEHEfectivo, Tipo = typeof(byte) },
                    new Parametro { NombreParametro = "@IdMotivoNoEfectivo", Valor = (string.IsNullOrEmpty(idMotivoNoEfectivo)) ? null : idMotivoNoEfectivo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Observaciones", Valor = (string.IsNullOrEmpty(observaciones)) ? null : observaciones, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdMatricula", Valor = idMatricula, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaCreacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                };

                resp = objBd.ejecutarProcedimiento("dbop_AddTBL_ENCUENTROEDUCATIVOHOGAR", parametros, "IdEncuentroEducativoHogar", DbType.Int32, 10);
                return resp.ToString();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool ActualizarEncuentroEducativoHogar(string idEncuentroEducativoHogar, string numeroIdentificacion, DateTime fechaHora, string idTipoEEH, string EEHNumero, string idMotivoEEH, string EEHEfectivo,
                                        string idMotivoNoEfectivo, string observaciones, string idMatricula, string idCoordinador, string idUsuarioCreacion)
        {
            try
            {
                Object resp;
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdEncuentroEducativoHogar", Valor = (idEncuentroEducativoHogar), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaHora", Valor = fechaHora, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdTipoEEH", Valor = idTipoEEH, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@EEHNumero", Valor = EEHNumero, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdMotivoEEH", Valor = idMotivoEEH, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@EEHEfectivo", Valor = EEHEfectivo, Tipo = typeof(byte) },
                    new Parametro { NombreParametro = "@IdMotivoNoEfectivo", Valor = (string.IsNullOrEmpty(idMotivoNoEfectivo)) ? null : idMotivoNoEfectivo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Observaciones", Valor = (string.IsNullOrEmpty(observaciones)) ? null : observaciones, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdMatricula", Valor = idMatricula, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                };

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_ENCUENTROEDUCATIVOHOGAR", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public DataTable ObtenerEncuentroEducativoHogar(string idEncuentroEducativoHogar)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdEncuentroEducativoHogar", Valor = (idEncuentroEducativoHogar), Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_ENCUENTROEDUCATIVOHOGAR", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool EliminarEncuentroEducativoHogar(string idEncuentroEducativoHogar)
        {
            try
            {
                Object resp;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdEncuentroEducativoHogar", Valor = idEncuentroEducativoHogar, Tipo = typeof(string) },
                };

                resp = objBd.ejecutarProcedimiento("dbop_DeleteTBL_ENCUENTROEDUCATIVOHOGAR", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }
    }
}
