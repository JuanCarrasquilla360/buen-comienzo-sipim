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
    public class VisitaCabezaHogar
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

        public DataTable ConsultarVisitaCabezaHogar(string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                //parametros.Add(new Parametro { NombreParametro = "@IdPerfil", Valor = idPerfil, Tipo = typeof(byte) });
                //parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = idDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_VISITACABEZAHOGAR", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerVisitaCabezaHogar(string idDocumento)
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

        public bool InsertarVisitaCabezaHogar(string idDocumento, string tipoDocumento, string primerNombre, string segundoNombre, string primerApellido,
                                     string segundoApellido, DateTime? fechaNacimiento, string sexo, string comuna, string barrio, string direccion,
                                     string direccionObservaciones, string celular, string telefono, string nivelEducativo, string tipologiaFamiliar,
                                     string tipoSeguridadSocial, string eAPB, string observaciones,
                                     string idUsuarioCreacion, string idUsuarioModificacion)
        {
            try
            {
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = idDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdMaeTipoDocumento", Valor = tipoDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@PrimerNombre", Valor = primerNombre, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SegundoNombre", Valor = segundoNombre, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@PrimerApellido", Valor = primerApellido, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SegundoApellido", Valor = segundoApellido, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaNacimiento", Valor = fechaNacimiento, Tipo = typeof(DateTime?) });
                parametros.Add(new Parametro { NombreParametro = "@Sexo", Valor = sexo, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdComuna", Valor = comuna, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdBarrio", Valor = barrio, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Direccion", Valor = direccion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@DireccionObservaciones", Valor = direccionObservaciones, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Celular", Valor = celular, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Telefono", Valor = telefono, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdNivelEducativo", Valor = nivelEducativo, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdMaeTipologiaFamiliar", Valor = tipologiaFamiliar, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdMaeTipoSeguridadSocial", Valor = tipoSeguridadSocial, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdMaeEAPB", Valor = eAPB, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Observaciones", Valor = observaciones, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaCreacion", Valor = fechaCreacion, Tipo = typeof(DateTime?) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioModificacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaCreacion, Tipo = typeof(DateTime?) });


                objBd.ejecutarProcedimiento("dbop_AddTBL_VISITACABEZAHOGAR", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool ActualizarVisitaCabezaHogar(string idDocumento, string tipoDocumento, string primerNombre, string segundoNombre, string primerApellido,
                                     string segundoApellido, DateTime? fechaNacimiento, string sexo, string comuna, string barrio, string direccion,
                                     string direccionObservaciones, string celular, string telefono, string nivelEducativo, string tipologiaFamiliar,
                                     string tipoSeguridadSocial, string eAPB, string observaciones, string idUsuarioModificacion)
        {
            try
            {
                DateTime fechaModificacion = DateTime.Now;

                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = idDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdMaeTipoDocumento", Valor = tipoDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@PrimerNombre", Valor = primerNombre, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SegundoNombre", Valor = segundoNombre, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@PrimerApellido", Valor = primerApellido, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SegundoApellido", Valor = segundoApellido, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaNacimiento", Valor = fechaNacimiento, Tipo = typeof(DateTime?) });
                parametros.Add(new Parametro { NombreParametro = "@Sexo", Valor = sexo, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdComuna", Valor = comuna, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdBarrio", Valor = barrio, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Direccion", Valor = direccion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@DireccionObservaciones", Valor = direccionObservaciones, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Celular", Valor = celular, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Telefono", Valor = telefono, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdNivelEducativo", Valor = nivelEducativo, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdMaeTipologiaFamiliar", Valor = tipologiaFamiliar, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdMaeTipoSeguridadSocial", Valor = tipoSeguridadSocial, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdMaeEAPB", Valor = eAPB, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Observaciones", Valor = observaciones, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioModificacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaModificacion, Tipo = typeof(DateTime?) });

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_VISITACABEZAHOGAR", parametros);
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
