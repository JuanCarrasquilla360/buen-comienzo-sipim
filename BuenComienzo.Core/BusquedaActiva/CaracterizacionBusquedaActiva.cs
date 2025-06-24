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
    public class CaracterizacionBusquedaActiva
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

        public DataTable ConsultarCaracterizacionBusquedaActiva(string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_CARACTERIZACIONBUSQUEDAACTIVA", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool InsertarCaracterizacionBusquedaActiva(DateTime fechaHora, DateTime fechaNacimiento, string idTipoDocumento,
            string numeroIdentificacion, string primeroNombre, string segundoNombre, string primerApellido, string segundoApellido,
            string coordenadax, string coordenaday, string idComuna, string idBarrio, string idTipoParticipante, string idGenero,
            string telefono, string telefono2, string idDiscapacidad, string idInstitucionalizado, string idInstitucionalizadoCual,
            string idRealizadEnFestival, string observaciones, string firma, string evidenciaRegistro, string idUsuarioCreacion)
        {
            try
            {
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@FechaHora", Valor = fechaHora, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@FechaNacimiento", Valor = fechaNacimiento, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdTipoDocumento", Valor = idTipoDocumento, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@PrimeroNombre", Valor = primeroNombre, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@SegundoNombre", Valor = (string.IsNullOrEmpty(segundoNombre) ? null : segundoNombre), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@PrimerApellido", Valor = primerApellido, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@SegundoApellido", Valor = segundoApellido, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Coordenadax", Valor = coordenadax, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Coordenaday", Valor = coordenaday, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdComuna", Valor = idComuna, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdBarrio", Valor = idBarrio, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdTipoParticipante", Valor = idTipoParticipante, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdGenero", Valor = idGenero, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Telefono", Valor = telefono, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Telefono2", Valor = (string.IsNullOrEmpty(telefono2) ? null : telefono2), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdDiscapacidad", Valor = idDiscapacidad, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdInstitucionalizado", Valor = idInstitucionalizado, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdInstitucionalizadoCual", Valor = (string.IsNullOrEmpty(idInstitucionalizadoCual) ? null : idInstitucionalizadoCual), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdRealizadEnFestival", Valor = idRealizadEnFestival, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Observaciones", Valor = (string.IsNullOrEmpty(observaciones) ? null : observaciones), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Firma", Valor = firma, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@EvidenciaRegistro", Valor = evidenciaRegistro, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaCreacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = null, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaModificacion", Valor = null, Tipo = typeof(DateTime?) }
                };

                objBd.ejecutarProcedimiento("dbop_AddTBL_CARACTERIZACIONBUSQUEDAACTIVA", parametros);

                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool ActualizarCaracterizacionBusquedaActiva(string numeroIdentificacion, DateTime fechaHora, DateTime fechaNacimiento, 
            string idTipoDocumento, string primeroNombre, string segundoNombre, string primerApellido, string segundoApellido,
            string coordenadax, string coordenaday, string idComuna, string idBarrio, string idTipoParticipante, string idGenero,
            string telefono, string telefono2, string idDiscapacidad, string idInstitucionalizado, string idInstitucionalizadoCual,
            string idRealizadEnFestival, string observaciones, string firma, string evidenciaRegistro, string idUsuarioModificacion)
        {
            try
            {
                DateTime fechaModificacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaHora", Valor = fechaHora, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@FechaNacimiento", Valor = fechaNacimiento, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdTipoDocumento", Valor = idTipoDocumento, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@PrimeroNombre", Valor = primeroNombre, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@SegundoNombre", Valor = (string.IsNullOrEmpty(segundoNombre) ? null : segundoNombre), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@PrimerApellido", Valor = primerApellido, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@SegundoApellido", Valor = segundoApellido, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Coordenadax", Valor = coordenadax, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Coordenaday", Valor = coordenaday, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdComuna", Valor = idComuna, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdBarrio", Valor = idBarrio, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdTipoParticipante", Valor = idTipoParticipante, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdGenero", Valor = idGenero, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Telefono", Valor = telefono, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Telefono2", Valor = (string.IsNullOrEmpty(telefono2) ? null : telefono2), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdDiscapacidad", Valor = idDiscapacidad, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdInstitucionalizado", Valor = idInstitucionalizado, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdInstitucionalizadoCual", Valor = (string.IsNullOrEmpty(idInstitucionalizadoCual) ? null : idInstitucionalizadoCual), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdRealizadEnFestival", Valor = idRealizadEnFestival, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Observaciones", Valor = (string.IsNullOrEmpty(observaciones) ? null : observaciones), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Firma", Valor = firma, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@EvidenciaRegistro", Valor = evidenciaRegistro, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioModificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaModificacion, Tipo = typeof(DateTime) }
                };

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_CARACTERIZACIONBUSQUEDAACTIVA", parametros);

                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public DataTable ObtenerCaracterizacionBusquedaActiva(string numeroIdentificacion)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_CARACTERIZACIONBUSQUEDAACTIVA", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool EliminarCaracterizacionBusquedaActiva(string numeroIdentificacion)
        {
            try
            {
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) }
                };

                objBd.ejecutarProcedimiento("dbop_DeleteTBL_CARACTERIZACIONBUSQUEDAACTIVA", parametros);

                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool ValidarDocumentoExiste(string numeroIdentificacion)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_ValidarDocumentoCaracterizacionBusquedaActiva", parametros).Tables[0];

                return dtDatos.Rows.Count > 0;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }
    }
} 