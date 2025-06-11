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
    public class OrientacionServicio
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

        public DataTable ConsultarOrientacionServicio(string idCoordinador, string ordenar, string where, int desde, string hasta)
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

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_ORIENTACIONSERVICIO", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public string InsertarOrientacionServicio(string numeroIdentificacion, DateTime fechaHora, string numeroIdentificacionCuidador, string nombreCuidador, string celularCuidador,
                                        string idTipoOS, string lugarRemite, string observaciones, string idMatricula, string nombreArchivoGuid, string nombreArchivo, string orientacionCerrada, string idUsuarioCreacion)
        {
            try
            {
                Object resp;
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaHora", Valor = fechaHora, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdentificacionCuidador", Valor = numeroIdentificacionCuidador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NombreCuidador", Valor = nombreCuidador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@CelularCuidador", Valor = celularCuidador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdMotivoOrientacionServicio", Valor = idTipoOS, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@LugarRemite", Valor = lugarRemite, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Observaciones", Valor = observaciones, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdMatricula", Valor = idMatricula, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NombreArchivoGuid", Valor = nombreArchivoGuid, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NombreArchivo", Valor = nombreArchivo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@OrientacionCerrada", Valor = orientacionCerrada, Tipo = typeof(byte) },
                    new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaCreacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                };

                resp = objBd.ejecutarProcedimiento("dbop_AddTBL_ORIENTACIONSERVICIO", parametros, "IdOrientacionServicio", DbType.Int32, 10);
                return resp.ToString();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool ActualizarOrientacionServicio(string idOrientacionServicio, string nombreArchivoGuid, string nombreArchivo, DateTime fechaPrimerSeguimiento, 
                                                    string observacionPrimerSeguimiento, DateTime fechaSegundoSeguimiento, string observacionSegundoSeguimiento,
                                                    string orientacionCerrada, string idUsuarioCreacion)
        {
            try
            {
                Object resp;
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdOrientacionServicio", Valor = (idOrientacionServicio), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NombreArchivoGuid", Valor = nombreArchivoGuid, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NombreArchivo", Valor = nombreArchivo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaPrimerSeguimiento", Valor = fechaPrimerSeguimiento, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@ObservacionPrimerSeguimiento", Valor = observacionPrimerSeguimiento, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaSegundoSeguimiento", Valor = fechaSegundoSeguimiento, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@ObservacionSegundoSeguimiento", Valor = observacionSegundoSeguimiento, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@OrientacionCerrada", Valor = orientacionCerrada, Tipo = typeof(byte) },
                    new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                };

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_ORIENTACIONSERVICIO", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public DataTable ObtenerOrientacionServicio(string idOrientacionServicio)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdOrientacionServicio", Valor = (idOrientacionServicio), Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_ORIENTACIONSERVICIO", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }


    }
}
