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
    public class Cronograma
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

        public DataTable ConsultarCronograma(string idDocumento, string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idDocumento, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_CRONOGRAMAS", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerCronogramaEncuentro(string idDocumento, string idProgramacionActividades)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = string.IsNullOrEmpty(idDocumento) ? null : idDocumento, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdProgramacionActividades", Valor = string.IsNullOrEmpty(idProgramacionActividades) ? null : idProgramacionActividades , Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_CRONOGRAMASENCUENTRO", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerCronograma(string idProgramacionActividades)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdProgramacionActividades", Valor = (idProgramacionActividades), Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_CRONOGRAMAS", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool ExisteCronograma(string idCoordinador, string idSede, string idTipoEncuentro, DateTime FechaHora)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdSede", Valor = idSede, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdTipoEncuentro", Valor = idTipoEncuentro, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaHora", Valor = FechaHora, Tipo = typeof(DateTime) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Val_CRONOGRAMAS", parametros).Tables[0];

                if (dtDatos.Rows.Count > 0)
                    return true;
                else
                    return false;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public string InsertarCronograma(string idCoordinador, string idSede, string idTipoEncuentro, DateTime fecha, string idAgenteEducativo1, string idAgenteEducativo2,
                                        string puntoReferencia, string idUsuarioCreacion)
        {
            try
            {
                Object resp;
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdSede", Valor = idSede, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdTipoEncuentro", Valor = idTipoEncuentro, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaHora", Valor = fecha, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdAgenteEducativo1", Valor = idAgenteEducativo1, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdAgenteEducativo2", Valor = (string.IsNullOrEmpty(idAgenteEducativo2)) ? null : idAgenteEducativo2, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@PuntoReferencia", Valor = (string.IsNullOrEmpty(puntoReferencia)) ? null : puntoReferencia, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaCreacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                };

                resp = objBd.ejecutarProcedimiento("dbop_AddTBL_CRONOGRAMAS", parametros, "IdProgramacionActividades", DbType.Int32, 10);
                return resp.ToString();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool ActualizarCronograma(string idProgramacionActividades, string motivoReprogramacion, string observacionesReprogramacion, string idUsuarioModificacion)
        {
            try
            {
                DateTime fechaModificacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdProgramacionActividades", Valor = idProgramacionActividades, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdMotivoReprogramacion", Valor = motivoReprogramacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@ObservacionesReprogramacion", Valor = observacionesReprogramacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioModificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaModificacion, Tipo = typeof(DateTime) },
                };

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_CRONOGRAMAS", parametros);
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
