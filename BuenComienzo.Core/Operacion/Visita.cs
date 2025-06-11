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
    public class Visita
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

        public DataTable ConsultarVisita(string idDocumento, byte idPerfil, string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdPerfil", Valor = idPerfil, Tipo = typeof(byte) });
                parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = idDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_VISITA", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerVisita(string idVisita)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdVisita", Valor = idVisita, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_VISITA", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }
        public bool InsertarVisita(string documentoCabezaHogar, string idDocumento, string tipoDocumento, string primerNombre, string segundoNombre, 
                                     string primerApellido, string segundoApellido, DateTime? fechaNacimiento, string sexo, 
                                     string celular, string telefono, DateTime? fechaVisita, string programa, string actividadVisita, string efectiva,
                                     string enfermeria, string nutricion, string saludBucal, string saludAmbiental, 
                                     string saludMental, string spa, string areaSocial, string observaciones, 
                                     string idUsuarioCreacion, string idUsuarioModificacion)
        {
            try
            {
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdCabezaHogar", Valor = documentoCabezaHogar, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = idDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdMaeTipoDocumento", Valor = tipoDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@PrimerNombre", Valor = primerNombre, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SegundoNombre", Valor = segundoNombre, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@PrimerApellido", Valor = primerApellido, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SegundoApellido", Valor = segundoApellido, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaNacimiento", Valor = fechaNacimiento, Tipo = typeof(DateTime?) });
                parametros.Add(new Parametro { NombreParametro = "@Sexo", Valor = sexo, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Celular", Valor = celular, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Telefono", Valor = telefono, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaVisita", Valor = fechaVisita, Tipo = typeof(DateTime?) });
                parametros.Add(new Parametro { NombreParametro = "@Programa", Valor = programa, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdMaeActividadVisita", Valor = actividadVisita, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Efectiva", Valor = efectiva, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Enfermeria", Valor = enfermeria, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Nutricion", Valor = nutricion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SaludBucal", Valor = saludBucal, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SaludAmbiental", Valor = saludAmbiental, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SaludMental", Valor = saludMental, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Spa", Valor = spa, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@AreaSocial", Valor = areaSocial, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Observaciones", Valor = observaciones, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaCreacion", Valor = fechaCreacion, Tipo = typeof(DateTime?) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioModificacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaCreacion, Tipo = typeof(DateTime?) });


                objBd.ejecutarProcedimiento("dbop_AddTBL_VISITA", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool ActualizarVisita(string idVisita, string documentoCabezaHogar, string idDocumento, string tipoDocumento, string primerNombre, string segundoNombre,
                                     string primerApellido, string segundoApellido, DateTime? fechaNacimiento, string sexo,
                                     string celular, string telefono, DateTime? fechaVisita, string programa, string actividadVisita, string efectiva,
                                     string enfermeria, string nutricion, string saludBucal, string saludAmbiental,
                                     string saludMental, string spa, string areaSocial, string observaciones, 
                                     string idUsuarioModificacion)
        {
            try
            {
                DateTime fechaModificacion = DateTime.Now;

                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdVisita", Valor = idVisita, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdCabezaHogar", Valor = documentoCabezaHogar, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = idDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdMaeTipoDocumento", Valor = tipoDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@PrimerNombre", Valor = primerNombre, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SegundoNombre", Valor = segundoNombre, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@PrimerApellido", Valor = primerApellido, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SegundoApellido", Valor = segundoApellido, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaNacimiento", Valor = fechaNacimiento, Tipo = typeof(DateTime?) });
                parametros.Add(new Parametro { NombreParametro = "@Sexo", Valor = sexo, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Celular", Valor = celular, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Telefono", Valor = telefono, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaVisita", Valor = fechaVisita, Tipo = typeof(DateTime?) });
                parametros.Add(new Parametro { NombreParametro = "@Programa", Valor = programa, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdMaeActividadVisita", Valor = actividadVisita, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Efectiva", Valor = efectiva, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Enfermeria", Valor = enfermeria, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Nutricion", Valor = nutricion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SaludBucal", Valor = saludBucal, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SaludAmbiental", Valor = saludAmbiental, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SaludMental", Valor = saludMental, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Spa", Valor = spa, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@AreaSocial", Valor = areaSocial, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Observaciones", Valor = observaciones, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioModificacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaModificacion, Tipo = typeof(DateTime?) });

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_VISITA", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public DataTable ObtenerCabezaHogar(string idDocumento)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = (idDocumento), Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_VISITACABEZAHOGAR", parametros).Tables[0];

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
