using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;
using BuenComienzo.Core.Administracion.To;

namespace BuenComienzo.Core.BusquedaActiva
{
    public class CronogramaBusquedaActiva
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

        public DataTable ConsultarCronogramaBusquedaActiva(string idCoordinador, string ordenar, string where, int desde, string hasta)
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

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_CRONOGRAMABUSQUEDAACTIVA", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerCronogramaBusquedaActivaPorId(string idCronograma)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = "", Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Ordenar", Valor = "IdCronograma", Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Where", Valor = "WHERE IdCronograma = " + idCronograma, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Desde", Valor = "1", Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Hasta", Valor = "1", Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_CRONOGRAMABUSQUEDAACTIVA", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerCronogramaBusquedaActivaPorActividad(string idTipoActividad, string idActividad, string idCoordinador)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdTipoActividad", Valor = string.IsNullOrEmpty(idTipoActividad) ? null : idTipoActividad, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdActividad", Valor = string.IsNullOrEmpty(idActividad) ? null : idActividad, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = string.IsNullOrEmpty(idCoordinador) ? null : idCoordinador, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_CRONOGRAMABUSQUEDAACTIVABYACTIVIDAD", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool ExisteCronogramaBusquedaActiva(string idCoordinador, string idTipoActividad, string idActividad, string idBarrio, byte? idComuna)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdTipoActividad", Valor = idTipoActividad, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdActividad", Valor = idActividad, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdBarrio", Valor = string.IsNullOrEmpty(idBarrio) ? null : idBarrio, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdComuna", Valor = idComuna, Tipo = typeof(byte?) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Val_CRONOGRAMABUSQUEDAACTIVA", parametros).Tables[0];

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

        public string InsertarCronogramaBusquedaActiva(string idTipoActividad, string idActividad, string idCoordinador, 
                                                      string idBarrio, byte? idComuna, DateTime fechaEncuentro,
                                                      string idAgenteEducativo1, string idAgenteEducativo2, 
                                                      string puntoReferencia, string observaciones, string idUsuarioCreacion)
        {
            try
            {
                Object resp;
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdTipoActividad", Valor = idTipoActividad, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdActividad", Valor = idActividad, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdBarrio", Valor = string.IsNullOrEmpty(idBarrio) ? null : idBarrio, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdComuna", Valor = idComuna, Tipo = typeof(byte?) },
                    new Parametro { NombreParametro = "@FechaEncuentro", Valor = fechaEncuentro, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdAgenteEducativo1", Valor = idAgenteEducativo1, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdAgenteEducativo2", Valor = string.IsNullOrEmpty(idAgenteEducativo2) ? null : idAgenteEducativo2, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@PuntoReferencia", Valor = string.IsNullOrEmpty(puntoReferencia) ? null : puntoReferencia, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Observaciones", Valor = string.IsNullOrEmpty(observaciones) ? null : observaciones, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaCreacion", Valor = fechaCreacion, Tipo = typeof(DateTime) }
                };

                resp = objBd.ejecutarProcedimiento("dbop_AddTBL_CRONOGRAMABUSQUEDAACTIVA", parametros, "IdCronograma", DbType.Int32, 10);
                return resp.ToString();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool ActualizarCronogramaBusquedaActiva(string idCronograma, string idTipoActividad, string idActividad, 
                                                      string idCoordinador, string idBarrio, byte? idComuna, 
                                                      DateTime fechaEncuentro, string idAgenteEducativo1, string idAgenteEducativo2, 
                                                      string puntoReferencia, string observaciones, 
                                                      string idUsuarioModificacion)
        {
            try
            {
                DateTime fechaModificacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCronograma", Valor = idCronograma, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdTipoActividad", Valor = idTipoActividad, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdActividad", Valor = idActividad, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdBarrio", Valor = string.IsNullOrEmpty(idBarrio) ? null : idBarrio, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdComuna", Valor = idComuna, Tipo = typeof(byte?) },
                    new Parametro { NombreParametro = "@FechaEncuentro", Valor = fechaEncuentro, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdAgenteEducativo1", Valor = idAgenteEducativo1, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdAgenteEducativo2", Valor = string.IsNullOrEmpty(idAgenteEducativo2) ? null : idAgenteEducativo2, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@PuntoReferencia", Valor = string.IsNullOrEmpty(puntoReferencia) ? null : puntoReferencia, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Observaciones", Valor = string.IsNullOrEmpty(observaciones) ? null : observaciones, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioModificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaModificacion, Tipo = typeof(DateTime) }
                };

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_CRONOGRAMABUSQUEDAACTIVA", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool ActualizarReprogramacionCronogramaBusquedaActiva(string idCronograma, string motivoReprogramacion, 
                                                                    string observacionesReprogramacion, string idUsuarioModificacion)
        {
            try
            {
                DateTime fechaModificacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCronograma", Valor = idCronograma, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdMotivoReprogramacion", Valor = motivoReprogramacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@ObservacionesReprogramacion", Valor = observacionesReprogramacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioModificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaModificacion, Tipo = typeof(DateTime) }
                };

                objBd.ejecutarProcedimiento("dbop_UpdateReprogramacionTBL_CRONOGRAMABUSQUEDAACTIVA", parametros);
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